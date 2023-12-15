import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/contact_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:sqflite/sqflite.dart';

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
  Future<void> insertAllconnections(MsgMeeContacts user);
  Future<List<MsgMeeContacts>> getAllConnections();
  Future<void> deleteTable(Database database, String tableName);
}

abstract class AbChatRoomsRepository with SQLiteMixin {
  Future<void> insertRooms(Room room);
  Future<List<Room>> getRooms();
  Future<void> deleteTable();
}

abstract class AbMessagesRepository with SQLiteMixin {
  Future<void> insertMessages(Message messages);
  Future<List<Message>> getMessages();
  Future<List<Message>> getMessagesById(String room);
  Future<void> deleteTable();
  Future<List<Message>> getPendingMessage();
  Future<void> updateDb(String id);
}
