import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/cubit/producer_cubit.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../connectivity/socket_service.dart';
import '../connectivity/web_socket.dart';
import '../feature/f_call/model/peer.dart';
import '../feature/f_call/model/producer.dart';


class CallMediaRepository {
    final ProducerCubit producersBloc;
  final CallMediaCubit mediaDevicesBloc;
  final String url;
  final String? displayName = "";

  bool _closed = false;
  WebSocket? _webSocket;
  Device? _mediasoupDevice;
  Transport? _sendTransport;
  late Transport transport;
  Transport? _recvTransport;
  late Transport? _transport_g;
  bool _produce = false;
  bool _consume = true;
  StreamSubscription<CallMediaState>? _mediaDevicesBlocSubscription;
  String? audioInputDeviceId;
  String? audioOutputDeviceId;
  String? videoInputDeviceId;

  List<Peer> peerList = [];
  List<Producern> producerList = [];
  List<String> comsumersList = [];

  CallMediaRepository._internal({
    required this.producersBloc,
    required this.url,
    required this.mediaDevicesBloc,
  }) {
    _mediaDevicesBlocSubscription =
        mediaDevicesBloc.stream.listen((CallMediaState state) async {
      if (state.selectedAudioInput != null &&
          state.selectedAudioInput?.deviceId != audioInputDeviceId) {
        await disableMic();
        enableMic();
      }

      if (state.selectedVideoInput != null &&
          state.selectedVideoInput?.deviceId != videoInputDeviceId) {
        await disableWebcam();
        enableWebcam();
      }
    });
  }

  static final CallMediaRepository _instance = CallMediaRepository._internal(
    producersBloc: ProducerCubit(),
    url: "", // Provide the default URL
    mediaDevicesBloc: CallMediaCubit(),
  );

  factory CallMediaRepository() {
    return _instance;
  }

  void close() {
    if (_closed) {
      return;
    }
 //   CallMediaRepository repository = CallMediaRepository();
    _webSocket?.close();
    _sendTransport?.close();
    _recvTransport?.close();
    _mediaDevicesBlocSubscription?.cancel();
  }
  Future<void> disableMic() async {
    String micId = producersBloc.state.mic!.id;

   // producersBloc.add(ProducerRemove(source: 'mic'));

    try {
      await _webSocket!.request('closeProducer', {
        'producerId': micId,
      });
    } catch (error) {}
  }

  Future<void> disableWebcam() async {
   // meBloc.add(MeSetWebcamInProgress(progress: true));
    String webcamId = producersBloc.state.webcam!.id;

   // producersBloc.add(ProducerRemove(source: 'webcam'));

    try {
      await _webSocket!.request('closeProducer', {
        'producerId': webcamId,
      });
    } catch (error) {
    } finally {
     // meBloc.add(MeSetWebcamInProgress(progress: false));
    }
  }

  Future<void> muteMic() async {
  //  producersBloc.add(ProducerPaused(source: 'mic'));

    try {
      await _webSocket!.request('pauseProducer', {
        'producerId': producersBloc.state.mic!.id,
      });
    } catch (error) {}
  }

  Future<void> unmuteMic() async {
   // producersBloc.add(ProducerResumed(source: 'mic'));

    try {
      await _webSocket!.request('resumeProducer', {
        'producerId': producersBloc.state.mic!.id,
      });
    } catch (error) {}
  }

  void _producerCallback(Producer producer) {
    if (producer.source == 'webcam') {
     // meBloc.add(MeSetWebcamInProgress(progress: false));
    }
    producer.on('trackended', () {
      disableMic().catchError((data) {});
    });
    //producersBloc.add(ProducerAdd(producer: producer));
  }

  void _consumerCallback(dynamic consumer, [dynamic accept]) {
    //ScalabilityMode scalabilityMode = ScalabilityMode.parse(
    //  consumer.rtpParameters.encodings.first.scalabilityMode);
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    print(consumer);
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    accept({});
    //peersBloc.add(PeerAddConsumer(peerId: consumer.peerId, consumer: consumer));
  }

  Future<MediaStream> createAudioStream() async {
    audioInputDeviceId = mediaDevicesBloc.state.selectedAudioInput!.deviceId;
    Map<String, dynamic> mediaConstraints = {
      'audio': {
        'optional': [
          {
            'sourceId': audioInputDeviceId,
          },
        ],
      },
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);

    return stream;
  }

  Future<MediaStream> createVideoStream() async {
    videoInputDeviceId = mediaDevicesBloc.state.selectedVideoInput!.deviceId;
    print("Device ID");
    print(videoInputDeviceId);
    Map<String, dynamic> mediaConstraints = <String, dynamic>{
      'audio': false,
      'video': {
        'mandatory': {
          'minWidth':
              '1280', // Provide your own width, height and frame rate here
          'minHeight': '720',
          'minFrameRate': '30',
        },
        'optional': [
          {
            'sourceId': videoInputDeviceId,
          },
        ],
      },
    };

    // final mediaConstraints = <String, dynamic>{
    //   'audio': true,
    //   'video': {
    //     'mandatory': {
    //       'minWidth':
    //           '1280', // Provide your own width, height and frame rate here
    //       'minHeight': '720',
    //       'minFrameRate': '30',
    //     },
    //   }
    // };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    //var stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    return stream;
  }

  void enableWebcam() async {
    print("Requestion webcam");
    // if (meBloc.state.webcamInProgress) {
    //   print("Requestion webcam is started returning because in progress...");
    //   return;
    // }
    print("In progress false");
   // meBloc.add(MeSetWebcamInProgress(progress: true));
    if (_mediasoupDevice!.canProduce(RTCRtpMediaType.RTCRtpMediaTypeVideo) ==
        false) {
      return;
    }
    MediaStream? videoStream;
    MediaStreamTrack? track;
    try {
      // NOTE: prefer using h264
      final videoVPVersion = kIsWeb ? 9 : 8;
      RtpCodecCapability? codec = _mediasoupDevice!.rtpCapabilities.codecs
          .firstWhere(
              (RtpCodecCapability c) =>
                  c.mimeType.toLowerCase() == 'video/vp$videoVPVersion',
              orElse: () =>
                  throw 'desired vp$videoVPVersion codec+configuration is not supported');
      videoStream = await createVideoStream();
      track = videoStream.getVideoTracks().first;
     // meBloc.add(MeSetWebcamInProgress(progress: true));
      // transport!.produce(
      //   track: track,
      //   codecOptions: ProducerCodecOptions(
      //     videoGoogleStartBitrate: 1000,
      //   ),
      //   encodings: kIsWeb
      //       ? [
      //           RtpEncodingParameters(
      //               scalabilityMode: 'S3T3_KEY', scaleResolutionDownBy: 1.0),
      //         ]
      //       : [],
      //   stream: videoStream,
      //   appData: {
      //     'source': 'webcam',
      //   },
      //   source: 'webcam',
      //   codec: codec,
      // );
      transport.produce(
        stream: videoStream,
        track: track,
        source: 'webcam',
      );
    } catch (error) {
      print("Error while enabling webcam");
      print(error);
      if (videoStream != null) {
        await videoStream.dispose();
      }
    }
  }

  void enableMic() async {
    print("Enabling microphone");
    if (_mediasoupDevice!.canProduce(RTCRtpMediaType.RTCRtpMediaTypeAudio) ==
        false) {
      print("Cannot enable returning false...");
      return;
    }

    MediaStream? audioStream;
    MediaStreamTrack? track;
    try {
      audioStream = await createAudioStream();
      track = audioStream.getAudioTracks().first;
      transport.produce(
        track: track,
        codecOptions: ProducerCodecOptions(opusStereo: 1, opusDtx: 1),
        stream: audioStream,
        appData: {
          'source': 'mic',
        },
        source: 'mic',
      );
    } catch (error) {
      if (audioStream != null) {
        await audioStream.dispose();
      }
    }
  }

  Future<void> _joinRoom() async {
    try {
      _mediasoupDevice = Device();

      dynamic routerRtpCapabilities =
          await _webSocket!.request('getRouterRtpCapabilities', {});

      print(routerRtpCapabilities);

      final rtpCapabilities = RtpCapabilities.fromMap(routerRtpCapabilities);
      rtpCapabilities.headerExtensions
          .removeWhere((he) => he.uri == 'urn:3gpp:video-orientation');
      await _mediasoupDevice!.load(routerRtpCapabilities: rtpCapabilities);

      if (_mediasoupDevice!.canProduce(RTCRtpMediaType.RTCRtpMediaTypeAudio) ==
              true ||
          _mediasoupDevice!.canProduce(RTCRtpMediaType.RTCRtpMediaTypeVideo) ==
              true) {
        _produce = true;
      }

      if (_produce) {
        Map transportInfo =
            await _webSocket!.request('createProducerTransport', {
          'forceTcp': false,
          'producing': true,
          'consuming': false,
          'sctpCapabilities': _mediasoupDevice!.sctpCapabilities.toMap(),
          'roomID': _webSocket?.roomId
        });

        _sendTransport = _mediasoupDevice!.createSendTransportFromMap(
          transportInfo,
          producerCallback: _producerCallback,
        );

        _sendTransport!.on('connect', (Map data) {
          _webSocket!
              .request('connectProducerTransport', {
                'transportId': _sendTransport!.id,
                'dtlsParameters': data['dtlsParameters'].toMap(),
              })
              .then(data['callback'])
              .catchError(data['errback']);
        });

        _sendTransport!.on('produce', (Map data) async {
          try {
            Map response = await _webSocket!.request(
              'produce',
              {
                'transportId': _sendTransport!.id,
                'kind': data['kind'],
                'rtpParameters': data['rtpParameters'].toMap(),
                'roomID': _webSocket?.roomId,
                if (data['appData'] != null)
                  'appData': Map<String, dynamic>.from(data['appData'])
              },
            );

            data['callback'](response['id']);
          } catch (error) {
            data['errback'](error);
          }
        });

        _sendTransport!.on('producedata', (data) async {
          try {
            Map response = await _webSocket!.request('produceData', {
              'transportId': _sendTransport!.id,
              'sctpStreamParameters': data['sctpStreamParameters'].toMap(),
              'label': data['label'],
              'protocol': data['protocol'],
              'appData': data['appData'],
            });

            data['callback'](response['id']);
          } catch (error) {
            data['errback'](error);
          }
        });
      }

      if (_consume) {
        Map transportInfo = await _webSocket!.request(
          'createConsumerTransport',
          {
            'forceTcp': false,
            'producing': false,
            'consuming': true,
            "roomID": _webSocket?.roomId,
            'sctpCapabilities': _mediasoupDevice!.sctpCapabilities.toMap(),
          },
        );

        _recvTransport = _mediasoupDevice!.createRecvTransportFromMap(
          transportInfo,
          consumerCallback: _consumerCallback,
        );

        _recvTransport!.on(
          'connect',
          (data) {
            _webSocket!
                .request(
                  'createConsumerTransport',
                  {
                    'transportId': _recvTransport!.id,
                    'dtlsParameters': data['dtlsParameters'].toMap(),
                  },
                )
                .then(data['callback'])
                .catchError(data['errback']);
          },
        );
      }

      Map response = await _webSocket!.request('join', {
        'displayName': displayName,
        'device': {
          'name': "Flutter",
          'flag': 'flutter',
          'version': '0.8.0',
        },
        "roomID": _webSocket?.roomId,
        'rtpCapabilities': _mediasoupDevice!.rtpCapabilities.toMap(),
        'sctpCapabilities': _mediasoupDevice!.sctpCapabilities.toMap(),
      });

      response['peers'].forEach((value) {
       // peersBloc.add(PeerAdd(newPeer: value));
      });

      if (_produce) {
        enableMic();
        enableWebcam();

        _sendTransport!.on('connectionstatechange', (connectionState) {
          if (connectionState == 'connected') {
            // enableChatDataProducer();
            // enableBotDataProducer();
          }
        });
      }
    } catch (error) {
      print(error);
      close();
    }
  }

  // void join() async{
  //   print("Added data");
  // }

  void joindd(peerId , roomId) {
    _webSocket = WebSocket(
      peerId: peerId,
      roomId: roomId,
      url: url,
      socket: SocketService().getSocket() as IO.Socket,
    );

    _joinRoom();

    _webSocket!.onDisconnected = () {
      if (_sendTransport != null) {
        _sendTransport!.close();
        _sendTransport = null;
      }
      if (_recvTransport != null) {
        _recvTransport!.close();
        _recvTransport = null;
      }
    };
    _webSocket!.onClose = () {
      if (_closed) return;

      close();
    };

    _webSocket!.onRequest = (request, accept, reject) async {
      switch (request['method']) {
        case 'newConsumer':
          {
            if (!_consume) {
              reject(403, 'I do not want to consume');
              break;
            }
            try {
              _recvTransport!.consume(
                id: request['data']['id'],
                producerId: request['data']['producerId'],
                kind: RTCRtpMediaTypeExtension.fromString(
                    request['data']['kind']),
                rtpParameters:
                    RtpParameters.fromMap(request['data']['rtpParameters']),
                appData: Map<String, dynamic>.from(request['data']['appData']),
                peerId: request['data']['peerId'],
                accept: accept,
              );
            } catch (error) {
              print('newConsumer request failed: $error');
              throw (error);
            }
            break;
          }
        default:
          break;
      }
    };

    _webSocket!.onNotification = (notification) async {
      switch (notification['method']) {
        //TODO: todo;
        case 'producerScore':
          {
            break;
          }
        case 'consumerClosed':
          {
            String consumerId = notification['data']['consumerId'];
            //peersBloc.add(PeerRemoveConsumer(consumerId: consumerId));

            break;
          }
        case 'consumerPaused':
          {
            String consumerId = notification['data']['consumerId'];
           // peersBloc.add(PeerPausedConsumer(consumerId: consumerId));
            break;
          }

        case 'consumerResumed':
          {
            String consumerId = notification['data']['consumerId'];
            //peersBloc.add(PeerResumedConsumer(consumerId: consumerId));
            break;
          }

        case 'newPeer':
          {
            final Map<String, dynamic> newPeer =
                Map<String, dynamic>.from(notification['data']);
            //peersBloc.add(PeerAdd(newPeer: newPeer));
            break;
          }

        case 'peerClosed':
          {
            String peerId = notification['data']['peerId'];
            //peersBloc.add(PeerRemove(peerId: peerId));
            break;
          }

        default:
          break;
      }
    };
  }

  //newlogic implementaion
  Future<void> subscribeNow(Device? mediasoupDevice, {socketID}) async {
    print("Statred subscription");
    var transportInfo = await _webSocket!.request(
      'createConsumerTransport',
      {
        'forceTcp': false,
        "roomID": _webSocket?.roomId,
        "socketID": socketID,
      },
    );
    print("After create Consumer transport");
    print(transportInfo);
    // if (transportInfo.error) {
    //   print("Error while creating consumerTransport");
    //   //return;
    // }
    print("No Errors till now going good");
    var transportConsumer = _mediasoupDevice!.createRecvTransportFromMap(
      transportInfo,
      consumerCallback: _consumerCallback,
    );

    transportConsumer.on(
      'connect',
      (data) {
        _webSocket!
            .request(
              'connectConsumerTransport',
              {
                'transportId': transportConsumer!.id,
                'dtlsParameters': data['dtlsParameters'].toMap(),
                'socketID': socketID
              },
            )
            .then(data['callback'])
            .catchError(data['errback']);
      },
    );

    transportConsumer.on('connectionstatechange', (connectionState) async {
      if (connectionState == 'connecting') {
        print("Connecting to transport");
      }

      if (connectionState == 'connected') {
        for (var producer in producerList) {
          // Your logic inside the loop
          await _webSocket
              ?.request("resume", {"producerID": producer.producerID});
        }
      }
      if (connectionState == 'failed') {
        print("Failed to connect");
      }
    });

    _transport_g = transportConsumer;
  }

  void join(peerId, roomId) async {
    _webSocket = WebSocket(
      peerId: peerId,
      roomId: roomId,
      url: url,
      socket: SocketService().getSocket() as IO.Socket,
    );

    Map response = await _webSocket!.request('join', {
      "roomID": _webSocket?.roomId,
    });
    print(
        "==================================================================================>");
        try {
         comsumersList = response['consumers']['content'].cast<String>();
         print("Printing consumers in array");
         print(comsumersList.length);
        } catch (e) {
          comsumersList.clear();
        }
        
    response['peers'].forEach((key, value) {
      print("addig peers");
      Peer newPeer = Peer.fromJson(value);
      peerList.add(newPeer);
    });
    response['producers'].forEach((value) {
      print("Adding producers");
      Producern producer = Producern.fromJson(value);
      producerList.add(producer);
    });
    print(
        "==================================================================================<");
    try {
      _mediasoupDevice = Device();

      dynamic routerRtpCapabilities =
          await _webSocket!.request('getRouterRtpCapabilities', {});

      final rtpCapabilities = RtpCapabilities.fromMap(routerRtpCapabilities);
      rtpCapabilities.headerExtensions
          .removeWhere((he) => he.uri == 'urn:3gpp:video-orientation');
      print("Loading rtpCapabilities");
      await _mediasoupDevice!.load(routerRtpCapabilities: rtpCapabilities);
      print("Loaded rtpCapabilities");

      await subscribeNow(_mediasoupDevice);
      print("After subscription");
      //create OWN transport

      var transportInfo = await _webSocket!.request(
        'createProducerTransport',
        {
          'forceTcp': false,
          "roomID": _webSocket?.roomId,
          "rtpCapabilities": _mediasoupDevice?.rtpCapabilities.toMap(),
        },
      );
      print("After created send transport");
      print(transportInfo);

      // if (transportInfo.error) {
      //   print("Error while creating consumerTransport");
      //   return;
      // }
      print("No Error ALL good till now");

      transport = _mediasoupDevice!.createSendTransportFromMap(
        transportInfo,
        producerCallback: _producerCallback,
      );
      transport.on('connect', (Map data) {
        _webSocket!
            .request('connectProducerTransport', {
              'transportId': transport?.id,
              'dtlsParameters': data['dtlsParameters'].toMap(),
            })
            .then(data['callback'])
            .catchError(data['errback']);
      });
      print("Listening produce");

      transport.on('produce', (Map data) async {
        try {
          Map response = await _webSocket!.request(
            'produce',
            {
              'transportId': transport.id,
              'kind': data['kind'],
              'rtpParameters': data['rtpParameters'].toMap(),
              'roomID': _webSocket?.roomId,
              "isScreen": false,
              if (data['appData'] != null)
                'appData': Map<String, dynamic>.from(data['appData'])
            },
          );

          data['callback'](response['id']);
        } catch (error) {
          data['errback'](error);
        }
      });

      transport.on('connectionstatechange', (connectionState) async {
        if (connectionState == 'connecting') {
          print("Connecting to transport");
        }

        if (connectionState == 'connected') {}
        if (connectionState == 'failed') {
          transport.close();
        }
      });

      //await produceVideo();
      print("Enabling medias");
       if (producerList.length > 0) {
        await initConsume(roomId);
      }
return;
      enableMic();
      enableWebcam();


      if (producerList.length > 0) {
        await initConsume(roomId);
      }
    } catch (e) {}
  }
  
  FutureOr<void> initConsume(String roomId) async{
        print("Starting consuming");

 if (comsumersList.isEmpty) {
        comsumersList = [];
      }

    var newStreams = [];

    for (var producer in producerList) {
          print("producer found in list");

       if (!comsumersList.contains(producer.producerID) && producer.roomID == roomId) {
          comsumersList.add(producer.producerID.toString());
    print("got a consumer");

          var stream = await consumeNow(_transport_g, producer , roomId);

          stream.producerID = producer.producerID;
          stream.socketID = producer.socketID;
          stream.userID = producer.userID;

          newStreams.add(stream);

       }
      
    }

  }
  
  consumeNow(Transport? tansporterConsumer2, Producern producer , String roomId) async{

    print("Inside consumer consuming");
    var rtpCapabilities = _mediasoupDevice!.rtpCapabilities.toMap();

    var data = await _webSocket?.request('consume', {
      "rtpCapabilities":rtpCapabilities,
      "socketID": producer.socketID,
      "roomID" : roomId,
      "producerID": producer.producerID,
    });
print("consume request data");
print(data);
var peerId = "";
peerList.forEach((element) {
  
  if (element.socketID == producer.socketID) {
    print("Found peer in list");
    print(element.userID);
    peerId = element.userID.toString();
  }
 }); 
        tansporterConsumer2?.consume(
                id: data['id'],
                producerId: data['producerId'],
                kind: RTCRtpMediaTypeExtension.fromString(
                    data['kind']),
                rtpParameters:
                    RtpParameters.fromMap(data['rtpParameters']),
                //appData: Map<String, dynamic>.from(data['appData']),
                peerId: peerId,
                //accept: data['accetpt'],

              );



print("Print after consume");
      

  }
}
