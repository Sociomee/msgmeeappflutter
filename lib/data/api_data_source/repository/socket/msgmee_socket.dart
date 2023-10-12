import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../helper/local_data.dart';
import '../../repositories.dart';

class MsgmeeSocket {
  IO.Socket socket = IO.io('$mainbaseUrl', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  void connectSocket() async {
    log('connecting..');
    await socket.connect();
    socket.onConnect((data) {
      log('on connect---->$data');
    });
    socket.onConnectError((error) {
      log('Connection error: $error');
    });
    socket.on('time', (data) {
      // log('time--->$data');
    });
    socket.on('msgmee-qr-login', (data) {
      log('msgmee-qr-login ---->$data');
    });
    socket.onDisconnect((data) {
      log('on disconnect---->>$data');
      socket.connect();
    });
  }

  void sendLoginEvent() async {
    var authtoken = await Localdata().readData('token');
    var deviceId = await Localdata().readData('deviceId');
    Map<String, dynamic> deviceData = {
      "deviceId": deviceId,
      "token": authtoken
    };
    try {
      socket.emit(
        'msgmee-qr-login',
        [deviceData],
      );
      socket.on('msgmee-qr-login', (data) {
        log('msgmee-qr-login ---->$data');
      });
    } catch (e) {
      log('emit error--->$e');
    }
    log('deviceId $deviceId  \n token  $authtoken');
  }

  Future<bool> testSocketUrl(String url) async {
    log(url);
    final completer = Completer<bool>();
    final socket = IO.io(url, <String, dynamic>{
      'autoConnect': false,
      'connectTimeout': 5000,
    });

    socket.onConnect((_) {
      socket.disconnect();
      completer.complete(true);
    });

    socket.onError((error) {
      socket.disconnect();
      completer.complete(false);
    });

    socket.connect();
    log('comleter---->${completer.future}');
    return completer.future;
  }
}
