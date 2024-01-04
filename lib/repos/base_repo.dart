import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msgmee/connectivity/socket_service.dart';
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/data/model/chat_roomlist_model.dart';
import 'package:msgmee/data/model/config_model.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository/messages_repository.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:msgmee/helper/connectivity_service.dart';
import 'package:msgmee/helper/local_data.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../data/model/messages_model.dart';
import '../feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';

class BaseRepo {
  final String baseUrl = 'https://api.msgmee.com';
  final SQLiteHelper sqlite = SQLiteHelper();
  String token = "";
  String phone = "";
  String userId = "";
  bool isNew = false;
  bool isFirst = true;
  late Config configData;
  late Timer _internetCheckTimer;
  final _connectivityService = ConnectivityService();


  BaseRepo() {
   
    _startInternetCheckTimer();
  }

  void init() async {
    token = await Localdata().readData('token') ?? "";
    phone = await Localdata().readData('phone') ?? "";
    userId = await Localdata().readData("currentuserid") ?? "";
    bool isConnected = await _isConnected();
    if (token != "" && isConnected && isFirst) {
       configData = await getConfig(phone);
       await getUserInfo(token, configData);
       await syncRoomsFromServer(token, configData);
      // await syncMessages(token);
      isFirst=false;
    }

  }

   void _startInternetCheckTimer() {

     
    _internetCheckTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _processQueueIfConnected();
    });
  }

 void _processQueueIfConnected() async {
    if (await _isConnected()) {
      var socket =SocketService().getSocket();
      if(!(socket?.connected ?? false)){
        socket?.connect();
      }
      final results = await sqlite.database.query(Tables.MESSAGE , where: "sId=? order by id asc limit 5" , whereArgs: ["sId"]);
      if (results.length > 0) {
        for (var element in results) {
           Message msg = Message.fromJson(element);
           if(msg.room != null && msg.room != ""){
             var sentToServer = await ChatRepostory().sendMessageRemaining(msg);
            if(sentToServer.room != null){
              print("sent");
              await MessagesRepository().updateMessage(sentToServer.message , msg.id ?? 0);
            }
           }
        }
      }
    }
  }

  Future<bool> _isConnected() async {
    return await _connectivityService.checkConnection();
  }

Future<void> scheduleQueue() async{

}

  syncRoomsFromServer(token, Config configData) async {
    String? timestamp = isNew ? "200-10-10" : configData.syncedTill;
    ChatRoomsModel data = await ChatRepostory().getChatRoomList(timestamp);
    if (data.rooms != null) {
      List<Room> myrooms = data.rooms as List<Room>;
      print("Total rooms ${myrooms.length}");
      for (var room in myrooms) {
        await checkandinsertroomtodb(room);
      }
    }
  }

  getUserInfo(token, Config configData) async {}

  syncMessages(String id) async{
     final db = await SQLiteHelper().database;
    //final results = await db.delete(Tables.MESSAGE,where: "sId=sId");
    //  MessagesModel data = await ChatRepostory().getChatRoomMessages(id: id);
    // if (data != null) {
    //   List<Message> myrooms = data.room?.messages ?? [];
    //   for (var room in myrooms) {
    //     print("got it");
    //   }
    // }
  }

  Future<Config> getConfig(phone) async {
    final db = await SQLiteHelper().database;
    final results = await db
        .query('${Tables.CONFIG}', where: "phone= ? ", whereArgs: [phone]);
    if (results.isEmpty) {
      isNew = true;
      print("Creating new config");
      return await createNewConfig(db);
    } else {
      print("config found");
      return Config.fromJson(results[0]);
    }
  }

  Future<Config> createNewConfig(Database db) async {
    const tableName = Tables.CONFIG;
    final query = '''
      INSERT OR REPLACE INTO $tableName (phone, isSyncEnabled) VALUES (?, ?)
    ''';

    await db.execute(query, [
      phone,
      0,
    ]);
    return getConfig(phone);
  }
  get getuserId => userId;
  Future<void> checkandinsertroomtodb(Room room) async {
    final db = await SQLiteHelper().database;
    final results = await db
        .query('${Tables.ROOM}', where: "sId= ? ", whereArgs: [room.sId]);
    if (results.isEmpty) {
      const sql =
          "INSERT OR REPLACE INTO room (isBizPage, isMarketPlace, isBroadCast,title, description, followers, following, pageId, ownerId, sId, isGroup, lastAuthorId, lastMessageId, lastUpdate) VALUES (?, ?, ?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?)";
     
      await db.rawQuery(sql, [
        (room.isBizPage ?? false) ? 1 : 0,
        (room.isMarketPlace ?? false) ? 1 : 0,
        (room.isBroadCast ?? false) ? 1 : 0,
        room.title,
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
      await checkAndUpdatePeopleInsideRoom(room);
    } else {

      if (room.isGroup ?? false ||
              (room.isBizPage ?? false) ||
              (room.isBroadCast ?? false) ||
              (room.isMarketPlace ?? false)) {
        await checkAndUpdatePeopleInsideRoom(room);
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

    print("Checking messages");
    //await checkAndInsertRoomMessages(room,db);
    ChatRoomsCubit().getLocalChatRoomData();
  }

  Future<void> checkAndUpdatePeopleInsideRoom(Room room) async {
    final db = await SQLiteHelper().database;
    List<User> userList = room.people as List<User>;

    for (var people in userList) {
      final results = await db.query('${Tables.ROOMPEOPLE}',
          where: "user_id= ? and roomId=? ", whereArgs: [people.sId, room.sId]);
      if (!results.isEmpty) {
      } else {
        const sql =
            "INSERT OR REPLACE INTO roomPeople (user_id , roomId) values(?,?)";
        await db.rawQuery(sql, [people.sId,room.sId]);
      }
      await checkAndUpdateUser(people);
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
  
  Future<void> updateOrCreateContact(User people) async{
    try {
          final db = await SQLiteHelper().database;

      List<String> msgMeeContacts = people.msgMeeContacts ?? [];
      for (var contact in msgMeeContacts) {
        const sql =
            "INSERT OR REPLACE INTO roomPeople (id, user_id) values(?,?)";
          //  print(contact);
           // await db.rawQuery(sql, [room.sId, people.sId]);
      }
    } catch (e) {
      
    }
  }
  
  Future<void> checkAndInsertRoomMessages(Room room, Database db) async{
  
    var data = await ChatRepostory().getChatRoomMessagesNew(id: room.sId ?? "");
    for (var element in data) {
     final results = await db.query('${Tables.MESSAGE}',
          where: "sId= ? and room=? ", whereArgs: [element.sId, room.sId]);
      if (results.isEmpty) {
         await sqlite.database.insert(Tables.MESSAGE, {"sId" : element.sId , "authorId" : element.authorId , "room" : element.room , "date" : element.date , "content":element.content,"status" : element.status },
          conflictAlgorithm: ConflictAlgorithm.replace);
      }else{
       // print("Message already in db");
      }

    }
  }
  
}
