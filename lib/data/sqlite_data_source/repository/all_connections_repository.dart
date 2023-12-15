import 'dart:developer';

import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../newmodels/contact_model.dart';
import '../sqlite_helper.dart';

class AllConnectionRepository extends AbAllConnectionRepository {
  @override
  Future<List<MsgMeeContacts>> getAllConnections() async {
    final List<Map<String, dynamic>> maps =
        await sqlite.database.query(Tables.ALLCONNECTIONS);
    return List.generate(
      maps.length,
      (i) {
        return MsgMeeContacts(
          sId: maps[i]['sId'],
          socioMeeId: maps[i]['socioMeeId'],
          phone: maps[i]['phone'],
          username: maps[i]['username'],
          fullName: maps[i]['fullName'],
          otherProfileImage: maps[i]['otherProfileImage'],
          linkedTo: maps[i]['linkedTo'],
        );
      },
    );
  }

  @override
  Future<void> insertAllconnections(MsgMeeContacts user) async {
    try {
       final results = await sqlite.database
        .query('${Tables.ALLCONNECTIONS}', where: "phone= ? ", whereArgs: [user.phone]);
    if (results.isEmpty) {
       await sqlite.database.insert(Tables.ALLCONNECTIONS, user.toJson(),
           conflictAlgorithm: ConflictAlgorithm.replace);
           print("Created contacts");
      return;
    }else{
      await sqlite.database.update(Tables.ALLCONNECTIONS, {"fullName" : user.fullName , "otherProfileImage" : user.otherProfileImage , "socioMeeId" : user.socioMeeId , "linkedTo" : user.linkedTo});
      print("Updated contacts");
    }
    } catch (e) {
      print('Error while inserting contact $e');
    }
  }

  @override
  Future<void> deleteTable(Database database, String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }


  
}
