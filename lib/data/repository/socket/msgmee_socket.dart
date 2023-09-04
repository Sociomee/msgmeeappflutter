// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../repositories.dart';

class MsgmeeSocket {
  void sendMessage(String message) {
    var authtoken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGU0YjFkMDVjOWY1YjlkODYzZDhkZWMiLCJkZXZpY2VJZCI6IjY0ZTRiMWQwNWM5ZjViOWQ4NjNkOGRlYSIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI3MDkzMjgsImV4cCI6MTY5NTMwMTMyOH0.q1O3-Bli0eGzEVNiBd34KIu_AuBZ8Cpe8o49_XnIfV4';
    final Map<String, dynamic> queryParameters = {
      'uid': '64d4bd67f4d5a7cc8b1c17ff',
      'token': authtoken,
      'dId': '64df6bbc353134205847ccea',
      'udId': '64e4b1d05c9f5b9d863d8dec',
      'transport': 'websocket',
    };

    IO.Socket socket = IO.io(
        '$baseUrl',
        OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders(queryParameters)
            .build());

    log('Connected to socket 1');
    socket.on('Send Message', (data) {
      log('data---->$data');
    });
    log('Connected to socket 2');
    Map sendmessage = {
      "chatRoomId": "64df5296b57a6c7b3dfaf926",
      "chatRoomType": "DM",
      "message": {
        "text": message,
        "idempotentId": "321900f3-620c-4802-b0e7-87sdb1fb42bc",
        "timestamp": "2023-08-17T15:06:27.687Z",
        "sender": "64a43eec348eb7e678877213",
        "chatRoomId": "64df5296b57a6c7b3dfaf926",
        "chatRoomType": "DM",
        "isSent": false,
        "isDeleted": [],
        "attachments": []
      }
    };
    try {
      socket.onConnect((_) {
        log('Connected to socket');
        socket.emit('send-message-up', sendmessage);
        socket.on('read-message-up', (data) {
          // Handle the received message data here
          print('Received message: $data');
        });
      });
    } catch (e) {
      log('error ---->$e');
    }

    socket.onDisconnect((_) {
      log('Disconnected from socket');
    });
  }

  void closeSocketConnection() {
    var authtoken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGU0YjFkMDVjOWY1YjlkODYzZDhkZWMiLCJkZXZpY2VJZCI6IjY0ZTRiMWQwNWM5ZjViOWQ4NjNkOGRlYSIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI3MDkzMjgsImV4cCI6MTY5NTMwMTMyOH0.q1O3-Bli0eGzEVNiBd34KIu_AuBZ8Cpe8o49_XnIfV4';
    final Map<String, dynamic> queryParameters = {
      'uid': '64d4bd67f4d5a7cc8b1c17ff',
      'token': authtoken,
      'dId': '64df6bbc353134205847ccea',
      'udId': '64e4b1d05c9f5b9d863d8dec',
      'transport': 'websocket',
    };

    IO.Socket socket = IO.io(
        '$baseUrl',
        OptionBuilder()
            .setTransports(['websocket'])
            .setExtraHeaders(queryParameters)
            .build());
    // ignore: unnecessary_null_comparison
    if (socket != null) {
      socket.disconnect();
      log('Socket connection closed');
    }
  }
}
