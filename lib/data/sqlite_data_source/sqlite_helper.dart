import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Tables {
  static const String table1 = 'phonebook';
  static const String table2 = 'allconnections';
}

class SQLiteHelper {
  static final SQLiteHelper _instance = SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  SQLiteHelper._internal();
  late Database database;
  static const phonebooktable = '''
      CREATE TABLE ${Tables.table1} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        phone TEXT
      )
    ''';

  static const allconnectiontable = '''
      CREATE TABLE ${Tables.table2} (
        id TEXT PRIMARY KEY,
        socioMeeId TEXT,
        firstName TEXT,
        phone TEXT,
        lastName TEXT,
        username TEXT,
        fullName TEXT,
        otherProfileImage TEXT,
        linkedTo TEXT
      )
    ''';
  Future<void> initialize() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'msgmee_database.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(phonebooktable);
        await db.execute(allconnectiontable);
      },
    );
  }
}

// Extension method to convert PhoneBookUserModel to a map
// extension PhoneBookUserModelExtension on PhoneBookUserModel {
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'phone': phone,
//     };
//   }
// }
