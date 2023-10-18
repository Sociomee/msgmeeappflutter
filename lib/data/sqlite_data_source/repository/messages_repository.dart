import 'dart:developer';

import 'package:msgmee/data/model/local_message_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_helper.dart';

class MessagesRepository extends AbMessagesRepository {
  @override
  Future<void> deleteTable() async {
    final db = await sqlite.database;
    await db.delete(Tables.MESSAGE);
  }

  @override
  Future<List<LocalMessagesModel>> getMessages() async {
    try {
      final List<Map<String, dynamic>> maps =
          await sqlite.database.query(Tables.MESSAGE);
      return List.generate(
          maps.length, (i) => LocalMessagesModel.fromMap(maps[i]));
    } catch (e) {
      log('getting messages data from localDB: $e');
      return [];
    }
  }

  @override
  Future<void> insertMessages(LocalMessagesModel messages) async {
    try {
      await sqlite.database.insert(Tables.MESSAGE, messages.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log('insert messages data to localDb: $e');
    }
  }

  @override
  Future<List<LocalMessagesModel>> getMessagesById(String room) async {
    try {
      final List<Map<String, dynamic>> maps = await sqlite.database.query(
        Tables.MESSAGE,
        where: 'room = ?',
        whereArgs: [room],
      );
      return List.generate(
          maps.length, (i) => LocalMessagesModel.fromMap(maps[i]));
    } catch (e) {
      log('getting messages data from localDB: $e');
      return [];
    }
  }

  @override
  Future<List<LocalMessagesModel>> getPendingMessage() async {
    var pendingMessages = await sqlite.database.query(
      Tables.MESSAGE,
      where: 'status = ?',
      whereArgs: ['Waiting'],
    );
    return List.generate(pendingMessages.length,
        (i) => LocalMessagesModel.fromMap(pendingMessages[i]));
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
