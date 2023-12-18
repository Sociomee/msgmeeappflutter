import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/model/chat_roomlist_model.dart';
import 'package:msgmee/data/model/mesage_send_success_model.dart';
import 'package:msgmee/data/model/messages_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../helper/local_data.dart';
import '../../../model/create_room_model.dart';
import '../../../model/image_send_reponse_model.dart';
import '../../../model/user_model.dart';
import '../dio_provider.dart';

class ChatRepostory extends AbChatReporitory {
  var apiService = ApiService();
  var localData = Localdata();
  @override
  Future<ChatRoomsModel> getChatRoomList([String? timestamp]) async {
    var token = await localData.readData('token');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/rooms/list',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    print('$mainbaseUrl/api/rooms/list');
    print(token);
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
        checkandStoreRoomInLocalDb(data.room ?? Room());
        return data;
      } else {
        return MessagesModel();
      }
    } catch (e) {
      log('Error: $e');
      return MessagesModel();
    }
  }

  Future<List<Message>> getChatRoomMessagesNew({required String id}) async {
    try {
      var token = await localData.readData('token');
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
      print(response.statusCode);
      if (response.statusCode == 200) { 
         final parsedJson = response.data['room'] as Map<String,dynamic>;
         List<Message> msgLst = [];
         for (var element in parsedJson['messages']) {
          Message msg = Message.fromJson(element);
          msgLst.add(msg);
         }
        print(msgLst.length);
        return msgLst;
      } else {
        return [];
      }
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }

  @override
  Future<Room> createRoom({required String userid}) async {
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
    var data;
    if (response.statusCode == 200) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      try {
      print(response.data['room']['lastMessage']);
      data = Room.fromJson(response.data['room']);
      if(data.sId != null){
        checkandStoreRoomInLocalDb(data);
      }
      
      } catch (e) {
        print("Error ${e}");
      }
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
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
    print('$mainbaseUrl/api/message');
    print(token);
    print('send message params:\n$authorId\n$roomId\n$content\n$contentType');
    var mdata = {
        "roomID": roomId,
        "authorID": authorId,
        "content": content,
        "contentType": contentType
      };
      print(mdata);
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
    print('send message response:${response.statusCode}');
    if (response.statusCode == 200) {
      var data = MessageSendSuccessModel.fromJson(response.data);
      log('send message response:${data}');
      return data;
    } else {
      throw Exception();
    }
  }


  Future<MessageSendSuccessModel> sendMessageRemaining(Message message) async {
    var token = await localData.readData('token');
    print('$mainbaseUrl/api/message');
    print(token);
    print('send message params:\n${message.authorId}\n${message.room}\n${message.content}\n${message.type}');
    var mdata = {
        "roomID": message.room,
        "authorID": message.authorId,
        "content": message.content,
        "contentType": message.type
      };
      print(mdata);
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/message',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {
         "roomID": message.room,
        "authorID": message.authorId,
        "content": message.content,
        "contentType": message.type
      },
    );
    print('send message response:${response.statusCode}');
    if (response.statusCode == 200) {
      var data = MessageSendSuccessModel.fromJson(response.data);
      log('send message response:${data}');
      return data;
    } else {
      return MessageSendSuccessModel();
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
    //log('is typing response----->${response.statusCode}');
  }
  
  Future<void> checkandStoreRoomInLocalDb(Room room) async{
     var db = await SQLiteHelper().database;
     final results = await SQLiteHelper().database
        .query('${Tables.ROOM}', where: "sId= ? ", whereArgs: [room.sId]);
    if (results.isEmpty) {
      print("Creating new room");
        const sql =
          "INSERT OR REPLACE INTO room (isBizPage, isMarketPlace, isBroadCast, description, followers, following, pageId, ownerId, sId, isGroup, lastAuthorId, lastMessageId, lastUpdate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
     
      await SQLiteHelper().database.rawQuery(sql, [
        (room.isBizPage ?? false) ? 1 : 0,
        (room.isMarketPlace ?? false) ? 1 : 0,
        (room.isBroadCast ?? false) ? 1 : 0,
        room.description,
        room.followers,
        room.following,
        room.pageId,
        room.ownerId,
        room.sId,
        (room.isGroup ?? false) ? 1 : 0,
        room.lastAuthor,
        room.lastMessageId.toString(),
        room.lastUpdate.toString()
      ]);
    }else{
            print("Updating room");
       if (room.isGroup ?? false ||
              (room.isBizPage ?? false) ||
              (room.isBroadCast ?? false) ||
              (room.isMarketPlace ?? false)) {
      
        await db.update(
            '${Tables.ROOM}', {"lastMessageId": room.lastMessage?.sId.toString()},
            where: "sId=?",
            whereArgs: [room.sId],
            conflictAlgorithm: ConflictAlgorithm.replace);
      } else {
        await db.update(
            '${Tables.ROOM}', {"lastMessageId": room.lastMessage?.sId.toString()},
            where: "sId=?",
            whereArgs: [room.sId],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

      await checkAndUpdatePeopleInsideRoom(room);
  }

   Future<void> checkAndUpdatePeopleInsideRoom(Room room) async {
    final db = await SQLiteHelper().database;
    List<User> userList = room.people as List<User>;
    print("Total people inside room ${userList.length}");
    for (var people in userList) {
      await checkAndUpdateUser(people);
      //await updateOrCreateContact(people);
      final results = await db.query('${Tables.ROOMPEOPLE}',
          where: "user_id= ? and roomId=? ", whereArgs: [people.sId, room.sId]);
      if (!results.isEmpty) {
      } else {
        const sql =
            "INSERT OR REPLACE INTO roomPeople (user_id , roomId) values(?,?)";
        await db.rawQuery(sql, [people.sId,room.sId]);
      }
    }
  }

    Future<void> checkAndUpdateUser(User people) async {
    final db = await SQLiteHelper().database;
    try {
      final String insertQuery = '''
INSERT OR REPLACE INTO ${Tables.USER} (
    id,
    userName,
    fullName,
    firstName,
    lastName,
    phone,
    otp,
    linkedTo,
    role,
    picture,
    email,
    socioMeeId,
    otherProfileImage,
    tagLine
) VALUES (
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?
);
''';

    await db.rawInsert(insertQuery, [
      people.sId,
      people.username,
      people.fullName,
      people.firstName,
      people.lastName,
      people.phone,
      "123456",
      people.linkedTo,
      people.role,
      people.picture?.sId ?? "",
      people.email,
      people.socioMeeId,
      people.otherProfileImage,
      people.tagLine
    ]); 
    return;
    } catch (e) {
      print("Error while creating user record....");
    }
  }
  
  void updateRoom(MessagesModel data) {

  }
}
