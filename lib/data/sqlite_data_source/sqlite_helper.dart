import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Tables {
  static const String PHONEBOOK = 'phonebook';
  static const String ALLCONNECTIONS = 'allconnections';
  static const String USER = 'user';
  static const String ROOM = 'room';
  static const String MESSAGE = 'message';
}

class SQLiteHelper {
  static final SQLiteHelper _instance = SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  SQLiteHelper._internal();
  late Database database;
  static const phonebooktable = '''
      CREATE TABLE ${Tables.PHONEBOOK} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        phone TEXT
      )
    ''';

  static const allconnectiontable = '''
      CREATE TABLE ${Tables.ALLCONNECTIONS} (
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
  static const usertable = '''
      CREATE TABLE ${Tables.USER} (
        id TEXT PRIMARY KEY,
        userName TEXT,
        fullName TEXT,
        firstName TEXT,
        lastName TEXT,
        phone TEXT,
        otp TEXT,
        linkedTo TEXT
        role TEXT,
        favorites TEXT,
        tagLine TEXT,
        picture TEXT,
        email TEXT,
        socioMeeId TEXT,
        msgMeeContacts TEXT,
        otherProfileImage TEXT
      )
''';
  static const roomtable = '''
      CREATE TABLE ${Tables.ROOM} (
        id TEXT PRIMARY KEY,
        people TEXT,
        title TEXT,
        picture TEXT,
        isGroup TEXT,
        lastUpdate TEXT,
        lastAuthor TEXT,
        lastMessage TEXT
      )
    ''';
  static const messagetable = '''
      CREATE TABLE ${Tables.MESSAGE} (
        id TEXT PRIMARY KEY,
        author TEXT,
        file TEXT,
        room TEXT,
        date TEXT,
        content TEXT,
        type TEXT
      )
    ''';

  Future<void> initialize() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'msgmee_database.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(roomtable);
        await db.execute(messagetable);
        await db.execute(usertable);
        await db.execute(phonebooktable);
        await db.execute(allconnectiontable);
      },
    );
  }
}
