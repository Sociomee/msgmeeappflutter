import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/connectivity/socket_service.dart';
import 'package:msgmee/connectivity/web_socket.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/cubit/consumer_cubit.dart';
import 'package:msgmee/feature/f_call/enitity/peer_device.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../feature/f_call/cubit/producer_cubit.dart';
import '../feature/f_call/model/peer.dart';
import '../feature/f_call/model/producer.dart';
import 'package:msgmee/feature/f_call/enitity/peer.dart' as RP;

import '../repos/base_repo.dart';

class CallService {
  static final CallService _instance = CallService._internal();
  late BuildContext context;
  late ProducerCubit producersBloc;
  late CallMediaCubit mediaDevicesBloc;
  String url = "https://api.msgmee.com";
  String? displayName = "";
  bool webcamProgress = false;
  bool isVideo = false;
  bool isJoined = false;
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

  String currentRoomId = "";
  factory CallService() {
    return _instance;
  }

  CallService._internal();

  void close() {
    if (_closed) {
      return;
    }
    //   CallMediaRepository repository = CallMediaRepository();
    _webSocket?.close();
    _sendTransport?.close();
    _recvTransport?.close();
    _mediaDevicesBlocSubscription?.cancel();
    context.read<ConsumerCubit>().removeAllPeers();
  }

  void setContext(BuildContext context1) {
    context = context1;
  }

  void setProducerbloc() {
    producersBloc = context.read<ProducerCubit>();
  }

  Future<void> disableMic() async {
    String micId =
        producersBloc.state.mic == null ? "" : producersBloc.state.mic!.id;

    // producersBloc.add(ProducerRemove(source: 'mic'));

    try {
      await _webSocket!.request('closeProducer', {
        'producerId': micId,
      });
    } catch (error) {}
  }

  Future<void> disableWebcam() async {
    // meBloc.add(MeSetWebcamInProgress(progress: true));
    if(producersBloc.state.webcam == null){
      return;
    }
    String webcamId =  producersBloc.state.webcam!.id;

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

  void setMediaDevices(CallMediaCubit mdb) {
    mediaDevicesBloc = mdb;
    _mediaDevicesBlocSubscription =
        mediaDevicesBloc.stream.listen((CallMediaState state) async {
      if (state.selectedAudioInput != null &&
          state.selectedAudioInput?.deviceId != audioInputDeviceId) {
        await disableMic();
        //enableMic();
      }

      if (state.selectedVideoInput != null &&
          state.selectedVideoInput?.deviceId != videoInputDeviceId) {
        await disableWebcam();
        //enableWebcam();
      }
    });
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

  void _producerDataCallback(Producer producer) {
    print(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>recieved>>>>>>>>>>>>>debug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  }

  void _producerCallback(Producer producer) {
    if (producer.source == 'webcam') {
      webcamProgress = false;
    }
    producer.on('trackended', () {
      disableMic().catchError((data) {});
    });


    context.read<ProducerCubit>().handleProducerAdd( producer.source, producer);
  }

  void _consumerCallback(Consumer consumer, [dynamic accept]) {
    //ScalabilityMode scalabilityMode = ScalabilityMode.parse(
    //  consumer.rtpParameters.encodings.first.scalabilityMode);
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<consumer callback<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    print("Peer id" + consumer.peerId.toString());
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>>>>>consumer callback end>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    // accept();
    context.read<ConsumerCubit>().addPeerConsumer(consumer);
  }

  void _consumerDataCallback(Consumer consumer, [dynamic accept]) {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<consumer callback recieved<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
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
    if (webcamProgress) {
      print("Requestion webcam is started returning because in progress...");
      return;
    }
    print("In progress false");
    //meBloc.add(MeSetWebcamInProgress(progress: true));
    webcamProgress = true;
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

      //meBloc.add(MeSetWebcamInProgress(progress: true));
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
        context.read<ProducerCubit>().handleProducerRemove("webcam");
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

  Future<void> subscribeNow({socketID}) async {
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
    var tInfo = transportInfo as Map<String, dynamic>;
    print(tInfo);
    // if (transportInfo.error) {
    //   print("Error while creating consumerTransport");
    //   //return;
    // }
    print("No Errors till now going good");
    // var transportConsumer = _mediasoupDevice!.createRecvTransportFromMap(
    //   transportInfo,
    //   consumerCallback: _consumerCallback,
    // );
    print(
        "<><><><><>?<><><><><><>consumer transport deatils<><><><><><><><><><><>");
    var id = tInfo['id'];
    var iceParameter = tInfo['iceParameters'];
    var iceCandidate = tInfo['iceCandidates'] as List<dynamic>;
    var dtlsParameter = tInfo['dtlsParameters'];

    IceParameters iceParameters = IceParameters.fromMap(iceParameter);
    List<IceCandidate> iceCandidates =
        iceCandidate.map((element) => IceCandidate.fromMap(element)).toList();
    DtlsParameters dtlsParameters = DtlsParameters.fromMap(dtlsParameter);
    print(
        "<><><><><>?<><><><><><>consumer transport deatils end<><><><><><><><><><><>");

    _transport_g = _mediasoupDevice!.createRecvTransport(
        id: id,
        iceParameters: iceParameters,
        iceCandidates: iceCandidates,
        dtlsParameters: dtlsParameters,
        consumerCallback: _consumerCallback,
        dataConsumerCallback: _consumerDataCallback);

    _transport_g?.on(
      'connect',
      (data) {
        _webSocket!
            .request(
              'connectConsumerTransport',
              {
                'transportId': _transport_g?.id,
                'dtlsParameters': data['dtlsParameters'].toMap()
              },
            )
            .then(data['callback'])
            .catchError(data['errback']);
      },
    );

    _transport_g?.on('connectionstatechange', (connectionState) async {
      print(
          "cscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscsccscscsccscscscscscscsccscscsccs");
      if (connectionState == 'connecting') {
        print("Connecting to consumer transport");
      }

      if (connectionState == 'connected') {
        for (var producer in producerList) {
          // Your logic inside the loop
          await _webSocket
              ?.request("resume", {"producerID": producer.producerID});
        }
      }
      if (connectionState == 'failed') {
        print("Failed to connect consumer");
      }
      print(connectionState);
      print(
          "cscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscscsccscscsccscscscscscscsccscscsccs");
    });
  }

void _joinNow(peerId , roomId) async {

    var currentuserId = context.read<BaseRepo>().getuserId;
    Map response = await _webSocket!.request('join', {
      "roomID": _webSocket?.roomId,
    });

    try {
      comsumersList = response['consumers']['content'].cast<String>();
      print("Printing consumers in array now");
      print(comsumersList.length);
    } catch (e) {
      comsumersList.clear();
    }
    var filterPeer = [];
    response['peers'].forEach((key, value) {
      print("addig peers");
      Peer newPeer = Peer.fromJson(value);
      if (newPeer.userID != currentuserId) {
        if (!filterPeer.contains(newPeer.userID)) {
          peerList.add(newPeer);
          filterPeer.add(newPeer.userID);
          String displayName =
              newPeer.user?.fullName.toString() ?? "Anonymous User";
          context.read<ConsumerCubit>().addPeer(RP.Peer(
              id: newPeer.userID.toString(),
              displayName: displayName,
              device: PeerDevice()));
        }
      }
    });

    response['producers'].forEach((value) {
      print("Adding producers");
      Producern producer = Producern.fromJson(value);
      producerList.add(producer);
    });

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
      await subscribeNow();
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
        dataProducerCallback: _producerDataCallback,
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

       enableMic();
       if(isVideo){
        enableWebcam();
       }

      if (producerList.length > 0) {
        await initConsume(roomId);
      }
    } catch (e) {
      print(
          "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>");
      print(e);
      print(
          "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>");
    }
}

  void join(peerId, roomId) async {
    _webSocket = WebSocket(
      peerId: peerId,
      roomId: roomId,
      url: url,
      socket: SocketService().getSocket() as Socket,
    );

    _joinNow(peerId,roomId);
    
    //webNotification Event Register

    _webSocket!.onNewProducer = (newProducer) async {
      print("recieved new producer data ${newProducer}");
      print(newProducer);
      consumeNow(Producern(
          userID: newProducer['userID'],
          roomID: newProducer['roomID'],
          socketID: newProducer['socketID'],
          producerID: newProducer['producerID']));
    };
  }

  FutureOr<void> initConsume(String roomId) async {
    print("Starting consuming");

    if (comsumersList.isEmpty) {
      comsumersList = [];
    }

    for (var producer in producerList) {
      print("producer found in list");

      if (!comsumersList.contains(producer.producerID) &&
          producer.roomID == roomId) {
        print("producer found for consume ${producer.toJson()}");
      }
    }

    print("All done now play " + producerList.length.toString());
  }

  void testData() async {
    print(peerList.length);
    for (var element in peerList) {
      print(
          "sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
      print(element.userID);
      print(element.user?.firstName);
      print(
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    }
  }

  void consumeNow(Producern pro) async {
    var rtpCapabilities = _mediasoupDevice!.rtpCapabilities.toMap();
    print("started consumer request");

    var datac = {
      "rtpCapabilities": rtpCapabilities,
      "socketID": pro.socketID,
      "roomID": pro.roomID,
      "producerID": pro.producerID,
    };
    _webSocket?.socket.emitWithAck("consume", datac, ack: consumeCallback);
    print("printing consumer response");
    // print(data);
  }

  void consumeCallback(data) {
    print(
        "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmdaaaaaaaaaaaaaaaaaaaaaaaataaaaaaaaaaaaaaaaaaa");
    var id = data['id'];
    var producerId = data['producerId'];
    var kind = RTCRtpMediaTypeExtension.fromString(data['kind']);
    var rtpParameters = RtpParameters.fromMap(data['rtpParameters']);

    _transport_g?.consume(
        id: id,
        producerId: producerId,
        kind: kind,
        rtpParameters: rtpParameters,
        peerId: producerId);
    print(
        "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiisdddddddddddddddddddnbbbbbbsadklfmdklsfmkdfmk");
  }

  void onNewProducer(data) async {
    print("producer data");
    print(data);
  }

  void setVideoEnabled(bool isVideo) {
     isVideo = isVideo;
  }
  void setCallJoined(bool joined) {
     isJoined = joined;
  }
  get iscallJoined => isJoined;
  
}
