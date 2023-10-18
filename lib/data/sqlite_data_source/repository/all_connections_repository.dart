import 'dart:developer';

import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../sqlite_helper.dart';

class AllConnectionRepository extends AbAllConnectionRepository {
  @override
  Future<List<User>> getAllConnections() async {
    final List<Map<String, dynamic>> maps =
        await sqlite.database.query(Tables.ALLCONNECTIONS);
    return List.generate(
      maps.length,
      (i) {
        return User(
          sId: maps[i]['id'],
          socioMeeId: maps[i]['socioMeeId'],
          firstName: maps[i]['firstName'],
          phone: maps[i]['phone'],
          lastName: maps[i]['lastName'],
          username: maps[i]['username'],
          fullName: maps[i]['fullName'],
          otherProfileImage: maps[i]['otherProfileImage'],
          linkedTo: maps[i]['linkedTo'],
        );
      },
    );
  }

  @override
  Future<void> insertAllconnections(User user) async {
    try {
      await sqlite.database.insert(Tables.ALLCONNECTIONS, user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log('insert connection error $e');
    }
  }

  @override
  Future<void> deleteTable(Database database, String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }
}
