import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/messages_model.dart';
import '../model/phonebook_model.dart';
import 'sqlite_helper.dart';

mixin SQLiteMixin {
  final SQLiteHelper sqlite = SQLiteHelper();
}

abstract class AbPhoneBookUserRepository with SQLiteMixin {
  Future<void> insertPhoneBookUser(PhoneBookUserModel user);
  Future<List<PhoneBookUserModel>> getPhoneBookUsers();
  Future<void> deleteTable(Database database, String tableName);
}

abstract class AbAllConnectionRepository with SQLiteMixin {
  Future<void> insertAllconnections(User user);
  Future<List<User>> getAllConnections();
  Future<void> deleteTable(Database database, String tableName);
}

abstract class AbChatRoomsRepository with SQLiteMixin {
  Future<void> insertRooms(Room room);
  Future<List<Room>> getRooms();
  Future<void> deleteTable();
}
