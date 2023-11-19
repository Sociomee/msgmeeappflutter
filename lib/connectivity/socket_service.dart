import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../data/api_data_source/repositories.dart';
import '../helper/local_data.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  static IO.Socket? _socket;

  // Listener callback
  void Function(dynamic data)? _listenerCallback;

  // Set the listener callback
  void setListener(void Function(dynamic data) callback) {
    _listenerCallback = callback;
  }

  Future<void> initSocket() async {
    print("Initializing socket");
    if (_socket == null) {
      final token = await Localdata().readData('token');

      _socket = IO.io('$mainbaseUrl',  OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': "$token"})
          .build(),);

      // Add listeners for events
      // _socket?.onConnect((_) {
      //   print('Socket connected');
      //   _socket?.emit("authenticate", {token});
        
      // });

      _socket?.onConnect((data) {
      print('connected.... $data');
      try {
        _socket?.emit('authenticate', [token]);
      } catch (e) {
        print('authentication error $e');
      }
    });

      _socket?.onDisconnect((_) {
        print('Socket disconnected');
      });

       _socket?.on('onlineUsers', (data) {
          print(data);
      });

        _socket?.on('call', (data) {
          print("Incomming call");
          print(data);
      });


      _socket?.on('time', (data) {
        
      });

     _socket?.on('typing', (data) {
         print('IsTyping');
      });
       _socket?.on('authenticated', (data) {
         print('Received data auth: $data');
      });

       _socket?.on('message-in', (data) {
        print('Received data message: $data');
      });

      

      _socket?.on('customEvent', (data) {
        print('Received data: $data');
        // Handle the data as needed
        if (_listenerCallback != null) {
          _listenerCallback!(data);
        }
      });
    }
  }

  void closeSocket() {
    _socket?.disconnect();
  }

  void sendEvent(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  IO.Socket? getSocket() {
    return _socket;
  }
}
