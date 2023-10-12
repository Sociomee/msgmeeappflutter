import 'package:msgmee/data/model/phonebook_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:sqflite_common/sqlite_api.dart';

class PhoneBookUserRepository extends AbPhoneBookUserRepository {
  @override
  Future<void> deleteTable(Database database, String tableName) async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }

  @override
  Future<List<PhoneBookUserModel>> getPhoneBookUsers() async {
    final List<Map<String, dynamic>> maps =
        await sqlite.database.query(Tables.PHONEBOOK);
    return List.generate(maps.length, (i) {
      return PhoneBookUserModel(
        name: maps[i]['name'],
        phone: maps[i]['phone'],
      );
    });
  }

  @override
  Future<void> insertPhoneBookUser(PhoneBookUserModel user) async {
    await sqlite.database.insert(
      Tables.PHONEBOOK,
      user.toMap(), // Convert the user to a map for insertion
    );
  }
}
