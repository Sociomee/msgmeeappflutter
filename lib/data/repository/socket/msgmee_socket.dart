// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../helper/local_data.dart';
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
      log('time--->$data');
    });
    socket.onDisconnect((data) {
      log('on disconnect---->>$data');
      socket.connect();
    });
  }

  void sendLoginEvent(String result) async {
    Map<String, dynamic> data = jsonDecode(result);
    String deviceId = data['deviceId'];
    var authtoken = await Localdata().readData('token');
    socket.emit('msgmee-qr-login', {'deviceId': deviceId, 'token': authtoken});
    log('deviceId $deviceId  \n token  $authtoken');
  }

  Future<bool> testSocketUrl(String url) async {
    log(url);
    final completer = Completer<bool>();
    final socket = IO.io(url, <String, dynamic>{
      'autoConnect': false, // Disable auto-connect for testing
      'connectTimeout': 5000, // Set a timeout (in milliseconds)
    });

    socket.onConnect((_) {
      socket.disconnect();
      completer.complete(true); // URL is reachable
    });

    socket.onError((error) {
      socket.disconnect();
      completer.complete(false); // URL is not reachable
    });

    socket.connect();
    log('comleter---->${completer.future}');
    return completer.future;
  }
}
