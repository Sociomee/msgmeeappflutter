import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocket {
  final String peerId;
  final String roomId;
  final String url;
  IO.Socket socket;
  Function()? onOpen;
  Function()? onFail;
  Function()? onDisconnected;
  Function()? onClose;
  Function(dynamic request, dynamic accept, dynamic reject)? onRequest;
  Function(dynamic notification)? onNotification;

  IO.Socket get msocket => socket;

  WebSocket(
      {required this.peerId,
      required this.roomId,
      required this.url,
      required this.socket}) {
    // _socket = IO.io(
    //   '$url/?roomId=$roomId&peerId=$peerId',
    //   IO.OptionBuilder().setTransports(['websocket']).build(),
    // );

    socket.onConnect((data) => this.onOpen?.call());
    socket.onDisconnect((data) => this.onDisconnected?.call());
    socket.onError((error) => this.onFail?.call());
    socket.on('disconnect', (reason) => this.onClose?.call());
    socket.on('close', (reason) => this.onClose?.call());
    socket.on(
      'request',
      (data) => this.onRequest?.call(data, null, null),
    );
    socket.on(
      'notification',
      (data) => this.onNotification?.call(data),
    );

     socket.on(
      'request',
      (data) => {print("recieved request")},
    );
  }

  Future<dynamic> request(String type, [Map<String, dynamic> data = const {}]) {
    Completer<dynamic> completer = Completer<dynamic>();

    socket.emit(type, data); // Corrected line

    // Listen for the response event
    socket.once(type+"Responce", (response) {
      completer.complete(response);
    });

    return completer.future;
  }

  void close() {
    //socket.close();
    socket.emit('leave', { "roomID":roomId });
  }
}
