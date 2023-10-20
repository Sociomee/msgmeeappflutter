import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/model/chat_roomlist_model.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/data/model/mesage_send_success_model.dart';
import 'package:msgmee/data/model/messages_model.dart';

import '../../../../helper/local_data.dart';
import '../../../model/image_send_reponse_model.dart';
import '../dio_provider.dart';

class ChatRepostory extends AbChatReporitory {
  var apiService = ApiService();
  var localData = Localdata();
  @override
  Future<ChatRoomsModel> getChatRoomList() async {
    var token = await localData.readData('token');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/rooms/list',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    // log('chat room response: ${response.data}');
    if (response.statusCode == 200) {
      var data = ChatRoomsModel.fromJson(response.data);

      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MessagesModel> getChatRoomMessages({required String id}) async {
    try {
      var token = await localData.readData('token');
      log('token $token');
      // log('id $id');
      var response = await apiService.dio.post(
        '$mainbaseUrl/api/room/join',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {'id': id},
      );

      // log('message response:${response.data}');

      if (response.statusCode == 200) {
        var data = MessagesModel.fromJson(response.data);
        return data;
      } else {
        return MessagesModel();
      }
    } catch (e) {
      log('Error: $e');
      return MessagesModel();
    }
  }

  @override
  Future<CreateRoomModel> createRoom({required String userid}) async {
    var token = await localData.readData('token');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/room/create',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {'counterpart': userid},
    );
    // log('create room response:${response.data}');
    if (response.statusCode == 200) {
      var data = CreateRoomModel.fromJson(response.data);
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MessageSendSuccessModel> sendMessage({
    required String authorId,
    required String roomId,
    required content,
    required String contentType,
  }) async {
    var token = await localData.readData('token');
    log('send message params:\n$authorId\n$roomId\n$content\n$contentType');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/message',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {
        "roomID": roomId,
        "authorID": authorId,
        "content": content,
        "contentType": contentType
      },
    );
    log('send message response:${response.statusCode}');
    if (response.statusCode == 200) {
      var data = MessageSendSuccessModel.fromJson(response.data);
      log('send message response:${data}');
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ImageSendResponseModel> sendImage(
      {required File imageFile, required String filename}) async {
    var token = await localData.readData('token');
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path, filename: filename),
    });
    Response response = await apiService.dio.post(
      '$mainbaseUrl/api/upload',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: formData,
    );
    log('image upload image $response');
    return ImageSendResponseModel.fromJson(response.data);
  }

  @override
  Future typing(
      {required bool typing, required Map<String, dynamic> room}) async {
    var token = await localData.readData('token');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/typing',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {"isTyping": typing, "room": room},
    );
    log('is typing response----->${response.statusCode}');
  }
}
