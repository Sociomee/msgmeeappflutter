import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/typing/cubit/typing_cubit.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../data/api_data_source/repositories.dart';
import '../data/sqlite_data_source/repository/messages_repository.dart';
import '../feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import '../helper/local_data.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late BuildContext context;
  String currentRoomId = "" ;
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
        _socket?.connect();
      });

       _socket?.on('onlineUsers', (data) {
         // print(data);
      });

        _socket?.on('call', (data) {
          print("Incomming call");
         // print(data);
      });


      _socket?.on('time', (data) {
        
      });

     _socket?.on('typing', (data) {
         if(context.mounted){
            context.read<TypingCubit>().startTyping(data);
         }
         print("typing start");
           print(data);
         print("typing end");
      });
       _socket?.on('authenticated', (data) {
         print('Received data auth: $data');
      });

       _socket?.on('message-in', (data) {
          // Get the temporary directory       
        print('Received data message:${data["message"]}');
        Message msg = Message.fromJson(data["message"]);
        tempFunction(msg);
        print(msg.content);
      });

      _socket?.on("newProducer", (data) {
        print("New producer recieved");
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

  void setContext(BuildContext context1) {
    context = context1;
  }
  
  void tempFunction(Message msg) async{
    await MessagesRepository().insertMessages(msg);
    
    print("Current Room id is ${currentRoomId}");
    if(currentRoomId != ""){
      context.read<ChatRoomsCubit>().getLocalDBMessagesById(currentRoomId);
    }
   await context.read<ChatRoomsCubit>().checkRoomExistbyId(msg);
  }

  void setCurrentRoomId(String roomId) {
    currentRoomId = roomId;
  }

 Future<dynamic> request(String type, [Map<String, dynamic> data = const {}]) {
    Completer<dynamic> completer = Completer<dynamic>();

    _socket?.emit(type, data); // Corrected line

    // Listen for the response event
    _socket?.once(type+"Responce", (response) {
      completer.complete(response);
    });

    return completer.future;
  }
  
}
