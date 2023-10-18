import 'package:msgmee/data/model/local_message_model.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/local_room_model.dart';
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
  Future<void> insertRooms(LocalChatRooms room);
  Future<List<LocalChatRooms>> getRooms();

  Future<void> deleteTable();
}

abstract class AbMessagesRepository with SQLiteMixin {
  Future<void> insertMessages(LocalMessagesModel messages);
  Future<List<LocalMessagesModel>> getMessages();
  Future<List<LocalMessagesModel>> getMessagesById(String room);
  Future<void> deleteTable();
  Future<List<LocalMessagesModel>> getPendingMessage();
  Future<void> updateDb(String id);
}
