import 'dart:async';
import 'dart:developer';

import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
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

  void getOnlineUsers(ChatRoomsCubit cubit) async {
    // var token = await Localdata().readData('token');
    // IO.Socket authenticatedSocket = IO.io('$mainbaseUrl', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': true,
    //   'query': 'token=$token',
    //   'extraHeaders': {
    //     'token': '$token',
    //   },
    // });
    // authenticatedSocket.on('onlineUsers', (data) {
    //   final List user = data;
    //   cubit.updateUserList(user);
    //   log('user is online--->$user');
    // });
  }

  void receivedMessage(ChatRoomsCubit cubit) async {
    // var token = await Localdata().readData('token');
    // IO.Socket authenticatedSocket = IO.io(
    //   '$mainbaseUrl',
    //   <String, dynamic>{
    //     'transports': ['websocket'],
    //     'autoConnect': false,
    //     'query': {'auth_token': token}
    //   },
    // );
    // IO.Socket authenticatedSocket = IO.io(
    //   mainbaseUrl,
    //   OptionBuilder()
    //       .setTransports(['websocket'])
    //       .disableAutoConnect()
    //       .setAuth({'authorization': "$token"})
    //       .build(),
    // );
    // authenticatedSocket.onConnect((data) {
    //   log('connected.... $data');
    //   try {
    //     authenticatedSocket.emit('authenticate', [token]);
    //   } catch (e) {
    //     log('authentication error $e');
    //   }
    // });
    // authenticatedSocket.onConnectError((error) {
    //   log('Connection error: $error');
    // });
    // authenticatedSocket.on('time', (data) {
    //   // log('time from message in response--->$data');
    // });
    // authenticatedSocket.on('typing', (data) {
    //   log('typing------>$data');
    // });
    // authenticatedSocket.on('authenticated', (data) {
    //   log('authenticated $data');
    // });
    // authenticatedSocket.on('message-in', (data) {
    //   log('message in response---------->$data');
    //   final Map<String, dynamic> messageData = data;
    //   final String roomID = messageData['room']['_id'];
    //   log('roomId -->$roomID');
    // });
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
