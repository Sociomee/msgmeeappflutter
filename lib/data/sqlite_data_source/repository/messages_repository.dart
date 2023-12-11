import 'dart:developer';

import 'package:msgmee/data/model/local_message_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_helper.dart';

class MessagesRepository extends AbMessagesRepository {
  @override
  Future<void> deleteTable() async {
    final db = await sqlite.database;
    await db.delete(Tables.MESSAGE);
  }

  @override
  Future<List<Message>> getMessages() async {
    try {
      final List<Map<String, dynamic>> maps =
          await sqlite.database.query(Tables.MESSAGE);
      return List.generate(
          maps.length, (i) => Message.fromJson(maps[i]));
    } catch (e) {
      log('getting messages data from localDB: $e');
      return [];
    }
  }

  @override
  Future<void> insertMessages(Message messages) async {
    try {
       final List<Map<String, dynamic>> maps = await sqlite.database.query(Tables.MESSAGE , where: "sId=?" , whereArgs: [messages.sId]);
      if(maps.isEmpty){
          await sqlite.database.insert(Tables.MESSAGE, {"sId" : messages.sId , "authorId" : messages.author?.sId , "room" : messages.room , "date" : messages.date , "content":messages.content,"status" : 1},
          conflictAlgorithm: ConflictAlgorithm.replace);
                print('insert messages data to localDb: ${messages.content}');

      }else{
        print('Already in db: ${messages.content}');
      }
      

    } catch (e) {
      print('insert messages data to localDb: $e');
    }
  }

  @override
  Future<List<Message>> getMessagesById(String room) async {
    try {
      final List<Map<String, dynamic>> maps = await sqlite.database.query(
        Tables.MESSAGE,
        where: 'room = ?',
        whereArgs: [room],
      );
      return List.generate(
          maps.length, (i) => Message.fromJson(maps[i]));
    } catch (e) {
      log('getting messages data from localDB: $e');
      return [];
    }
  }

  @override
  Future<List<Message>> getPendingMessage() async {
    var pendingMessages = await sqlite.database.query(
      Tables.MESSAGE,
      where: 'status = ?',
      whereArgs: ['Waiting'],
    );
    return List.generate(pendingMessages.length,
        (i) => Message.fromJson(pendingMessages[i]));
  }

  @override
  Future<void> updateDb(String id) async {
    await sqlite.database.update(
      Tables.MESSAGE,
      {'status': 'Sent'},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
