import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../connectivity/socket_service.dart';
import '../../../../connectivity/web_socket.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';

class CallScreen extends StatefulWidget {
  Room room;
  CallScreen({super.key, required this.room});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var mySignal = SocketService();
  var socket = SocketService().getSocket();
  final device = Device();
  Map<String, dynamic> routerRtpCapabilities = {};
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

  @override
  void initState() {
    // TODO: implement initState
    startCall();
    super.initState();
  }

    void _producerCallback(Producer producer) {
    if (producer.source == 'webcam') {
      //meBloc.add(MeSetWebcamInProgress(progress: false));
    }
    producer.on('trackended', () {
      //disableMic().catchError((data) {});
    });
   // producersBloc.add(ProducerAdd(producer: producer));
   print("Producer found");
  }

  void startCall() async {
   _webSocket = WebSocket(
      peerId: "652e6674c78cfd56a9c848c0",
      roomId: "6596a19d11528814d561196a",
      url: "https://api.msgmee.com",
      socket: socket as Socket ,
    );

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


        //add consumer logic

         Map response = await _webSocket!.request('join', {
        'displayName': "Seraj Alam",
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
        //peersBloc.add(PeerAdd(newPeer: value));
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
      }
    }
  }


 Future<MediaStream> createAudioStream() async {
    audioInputDeviceId = "0";//mediaDevicesBloc.state.selectedAudioInput!.deviceId;
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
    videoInputDeviceId = "0";//mediaDevicesBloc.state.selectedVideoInput!.deviceId;
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 86;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                splashColor: const Color.fromARGB(0, 244, 67, 54),
                onTap: () {
                  animatedScreenPop(context);
                },
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.errorRedColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.phone, color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [],
          ),
        ],
      )),
    );
  }
}
