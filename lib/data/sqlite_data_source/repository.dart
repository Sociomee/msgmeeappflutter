import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/phonebook_model.dart';

abstract class AbPhoneBookUserRepository {
  Future<void> insertPhoneBookUser(PhoneBookUserModel user);
  Future<List<PhoneBookUserModel>> getPhoneBookUsers();
  Future<void> deleteTable(Database database, String tableName);
}

abstract class AbAllConnectionRepository {
  Future<void> insertAllconnections(User user);
  Future<List<User>> getAllConnections();
  Future<void> deleteTable(Database database, String tableName);
}
