import 'dart:convert';
import 'dart:developer';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';

import '../../model/chat_roomlist_model.dart';
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
    try {
      final List<Map<String, dynamic>> maps =
          await sqlite.database.query(Tables.ROOM);

      return List.generate(maps.length, (i) {
        final List<dynamic> peopleJson = jsonDecode(maps[i]['people']);
        final List<People> peopleList =
            peopleJson.map((json) => People.fromJson(json)).toList();
        final Map<String, dynamic> lastMessageJson =
            jsonDecode(maps[i]['lastMessage']);
        final LastMessage lastMessage = LastMessage.fromJson(lastMessageJson);

        return Room(
          sId: maps[i]['id'],
          people: peopleList,
          isGroup: maps[i]['isGroup'],
          lastUpdate: maps[i]['lastUpdate'],
          lastMessage: lastMessage,
          lastAuthor: maps[i]['lastAuthor'],
        );
      });
    } catch (e) {
      log('getting room data from localDB: $e');
      return [];
    }
  }

  @override
  Future<void> insertRooms(Room room) async {
    try {
      await sqlite.database.insert(Tables.ROOM, room.toMap());
    } catch (e) {
      log('insert room data to localDb: $e');
    }
  }
}
