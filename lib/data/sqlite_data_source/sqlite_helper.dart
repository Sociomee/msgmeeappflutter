import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Tables {
  static const String PHONEBOOK = 'phonebook';
  static const String ALLCONNECTIONS = 'allconnections';
  static const String USER = 'user';
  static const String ROOM = 'room';
  static const String ROOMPEOPLE = 'roomPeople';
  static const String PICTURE = 'picture';
  static const String MESSAGE = 'message';
  static const String MEETING = 'meeting';
  static const String CONFIG = 'config';
  static const String MSGMEECONTACTS = "msgMeeContacts";  
  static const String FAVORITES = "favorites";

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

  static const configTable = '''
      CREATE TABLE ${Tables.CONFIG} (
        userId TEXT NULL,
        phone TEXT PRIMARY KEY,
        isSyncEnabled BOOLEAN DEFAULT 0,
        syncedTill TEXT DEFAULT CURRENT_TIMESTAMP
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
        role TEXT NULL,
        otp TEXT NULL,
        linkedTo TEXT NULL,
        picture TEXT NULL,
        email TEXT NULL,
        tagLine TEXT NULL,
        socioMeeId TEXT NULL,
        otherProfileImage TEXT NULL,
        lastOnline TEXT NULL,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
''';

 static const picturetable = '''
      CREATE TABLE ${Tables.PICTURE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isUrl BOOLEAN DEFAULT 0,
        sId TEXT,
        shield TEXT NULL,
        name TEXT NULL,
        author TEXT,
        size INTEGER NULL,
        location TEXT NULL,
        shieldedID TEXT NULL,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''';

  static const roomtable = '''
      CREATE TABLE ${Tables.ROOM} (
        sId TEXT PRIMARY KEY,
        title TEXT,
        picture_id TEXT DEFAULT "0",
        isGroup BOOLEAN DEFAULT 0,
        isBizPage BOOLEAN DEFAULT 0,
        isMarketPlace BOOLEAN DEFAULT 0,
        isBroadCast BOOLEAN DEFAULT 0,
        description TEXT DEFAULT "",
        followers INTEGER DEFAULT 0,
        following INTEGER DEFAULT 0,
        pageId TEXT DEFAULT "0",
        ownerId TEXT DEFAULT NULL,
        lastUpdate DATETIME,
        lastAuthorId TEXT NULL,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
        lastMessageId TEXT NULL
      )
    ''';

    static const userContactsTable = '''
      CREATE TABLE ${Tables.MSGMEECONTACTS} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sId TEXT,
        contactId TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''';

    static const userFavoriteTable = '''
      CREATE TABLE ${Tables.FAVORITES} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sId TEXT,
        contactId TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''';

 static const roomPeopletable = '''
      CREATE TABLE ${Tables.ROOMPEOPLE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        roomId TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''';

  static const messagetable = '''
      CREATE TABLE ${Tables.MESSAGE} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sId TEXT,
        authorId TEXT,
        room TEXT,
        date TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
        sentTime TEXT DEFAULT CURRENT_TIMESTAMP,
        content TEXT NULL,
        status INT DEFAULT 0,
        isDeleted INT DEFAULT 0
      )
    ''';

  static const meetingTable = '''
      CREATE TABLE ${Tables.MEETING} (
        id TEXT PRIMARY KEY,
        socioMeeId TEXT NULL,
        firstName TEXT NULL,
        phone TEXT NULL,
        lastName TEXT NULL,
        username TEXT NULL,
        fullName TEXT NULL,
        otherProfileImage TEXT NULL,
        linkedTo TEXT NULL
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
        await db.execute(meetingTable);
        await db.execute(roomPeopletable);
        await db.execute(configTable);
        await db.execute(picturetable);
        await db.execute(userContactsTable);
      },
    );
  }

  Future<void> clearAndReinitializeDatabase() async {
    await database.close();

    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'msgmee_database.db');
    await deleteDatabase(path);

    // Reinitialize the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(roomtable);
        await db.execute(messagetable);
        await db.execute(usertable);
        await db.execute(phonebooktable);
        await db.execute(allconnectiontable);
        await db.execute(meetingTable);
        await db.execute(roomPeopletable);
        await db.execute(configTable);
        await db.execute(picturetable);
        await db.execute(userContactsTable);

      },
    );
  }
}