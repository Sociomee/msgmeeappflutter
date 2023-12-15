import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/create_room_model.dart';
import '../../model/messages_model.dart';
import '../repository.dart';

class ChatRoomsRepository extends AbChatRoomsRepository {
  @override
  Future<void> deleteTable() async {
    final db = await sqlite.database;
    await db.delete(Tables.ROOM);
  }

  @override
  Future<List<Room>> getRooms() async {
    List<Room> roomData = [];
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
        print(commonData);
        fdata.add(commonData);
      }

      print(fdata.length);
      print(fdata.length > 0);

      if (fdata.length > 0) {
       try {
        print("issue in local room");
         roomData = fdata.map((e) => Room.fromJson(e)).toList();
       } catch (e) {
          print("error ${e}");
       }
       return roomData;
      }
    
      return [];
    } catch (e) {
      log('getting room data from localDB: $e');
      return [];
    }
  }

  @override
  Future<void> insertRooms(Room room) async {
    try {
      // await sqlite.database.insert(Tables.ROOM, room.toMap(),
      //     conflictAlgorithm: ConflictAlgorithm.replace);
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

    return {...roomData, 'people': peopleList};
  }

  return {...roomData, 'people': []};
}



}
