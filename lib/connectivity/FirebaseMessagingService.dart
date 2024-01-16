import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:msgmee/repos/base_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart';

import '../helper/local_data.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
 var localData = Localdata();
  Future<void> setupFirebase() async {
    _firebaseMessaging.getToken().then((String? token) {
      print("Firebase Token: $token");
      // Save the token to your database
      saveTokenToDatabase(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification?.body}");
      // Handle the notification message when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("App opened via notification");
      // Handle the notification message when the app is in the background
      handleNotificationClick(message);
    });

    // Set up the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void saveTokenToDatabase(String? token) {
    // Implement your logic to save the token to the database
    // This can be Firebase Realtime Database, Firestore, or any other database
  }

  void handleNotificationClick(RemoteMessage message) {
    // Implement your logic to handle the notification click when the app is in the background
    print("Notification clicked: ${message.notification?.body}");
     Map<String, dynamic> data = message.data;
     if (data.isNotEmpty) {

        // Access specific data parameters
        String type = data['type'];
        var rawData = data['data'];
        if(type == "message"){
          Map<String, dynamic> jsonMap = json.decode(rawData);
          String roomId = jsonMap["message"]['room'];
          String authorId = jsonMap["message"]['author']['_id'];
              localData.storedata('isNotificationTapped', "1");
              localData.storedata('n_user', authorId);
              localData.storedata('n_room', roomId);
        }
      }
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    Map<String, dynamic> data = message.data;
      if (data.isNotEmpty) {

        // Access specific data parameters
        String type = data['type'];
        var rawData = data['data'];
        if(type == "message"){
             ChatRepostory().createRoomOrAddremoteMessage(rawData);
        }
      }

    // Handle the background message here
  }
}
