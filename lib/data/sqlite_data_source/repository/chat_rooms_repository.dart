import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/create_room_model.dart';
import '../../model/local_room_model.dart';
import '../../model/messages_model.dart';
import '../repository.dart';

class ChatRoomsRepository extends AbChatRoomsRepository {
  @override
  Future<void> deleteTable() async {
    final db = await sqlite.database;
    await db.delete(Tables.ROOM);
  }

  @override
  Future<List<LocalChatRooms>> getRooms() async {
    try {
      final SQLiteHelper sqlite = SQLiteHelper();

      const sql = '''
                      SELECT * FROM room;
                      ''';
      final List<Map<String, dynamic>> maps =
        await sqlite.database.rawQuery(sql);
        var fdata = [];
        for (var element in maps) {
        var commonData = await getRoomWithPeopleFormatted(element["sId"]);
        fdata.add(commonData);
      }
      print("Loop completed..");

      print(fdata.length);
      if (fdata.length > 0) {
        print(
            "================================>>>>>>>>========================");
            fdata.forEach(((ele) {
              print(ele);
            }));
        print(
            "================================<<<<<<<<========================");
      }
      // final List<Map<String, dynamic>> maps = await sqlite.database.query(
      //   Tables.ROOM,
      // );

      // return List.generate(maps.length, (i) {
      //   final List<dynamic> peopleJson = jsonDecode(maps[i]['people']);
      //   final List<People> peopleList =
      //       peopleJson.map((json) => People.fromJson(json)).toList();
      //   final Map<String, dynamic> lastMessageJson =
      //       jsonDecode(maps[i]['lastMessage']);
      //   final LastMessage lastMessage = LastMessage.fromJson(lastMessageJson);

      //   return LocalChatRooms(
      //     sId: maps[i]['id'],
      //     people: peopleList,
      //     isGroup: maps[i]['isGroup'],
      //     lastUpdate: maps[i]['lastUpdate'],
      //     lastMessage: lastMessage,
      //     lastAuthor: maps[i]['lastAuthor'],
      //   );
      // });
      return [];
    } catch (e) {
      log('getting room data from localDB: $e');
      return [];
    }
  }

  @override
  Future<void> insertRooms(LocalChatRooms room) async {
    try {
      await sqlite.database.insert(Tables.ROOM, room.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log('insert room data to localDb: $e');
    }
  }
  



  Future<List<Map<String, dynamic>>> getRoomPeoples(String roomId) async {


  List<Map<String, dynamic>> result = await sqlite.database.rawQuery('''
    SELECT * , usr.id as _id FROM roomPeople rp LEFT JOIN user usr ON rp.user_id = usr.id where rp.roomId = ?
  ''',[roomId]);

  return result;
}

Future<Map<String, dynamic>> getRoomById(String roomId) async {
  List<Map<String, dynamic>> result = await sqlite.database.rawQuery('''
    SELECT * FROM room where sId = ?
  ''',[roomId]);

  return result[0];
}

  Future<Map<String, dynamic>> getRoomWithPeopleFormatted(String roomId) async {
  
  Map<String,dynamic> roomData = await getRoomById(roomId);
  List<Map<String, dynamic>> result = await getRoomPeoples(roomId);
  if (result.isNotEmpty) {

    List<Map<String, dynamic>> peopleList = result.toList();
print(peopleList);
print("Peoplelist");
    return {...roomData, 'people': peopleList};
  }

  return {...roomData, 'people': []};
}



}
