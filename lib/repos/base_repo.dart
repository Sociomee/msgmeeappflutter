import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/data/model/chat_roomlist_model.dart';
import 'package:msgmee/data/model/config_model.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';
import 'package:msgmee/helper/local_data.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';

class BaseRepo {
final String baseUrl = 'https://api.msgmee.com'; 
final SQLiteHelper sqlite = SQLiteHelper();
late final token;
late final phone;
late Config configData ;

BaseRepo(){
 
}

  void init() async{
  token = await Localdata().readData('token') ?? false;
  phone = await Localdata().readData('phone') ?? false;

  if(token != null){
    configData = await getConfig(phone);
    await getUserInfo(token ,configData);
    await syncRoomsFromServer(token , configData);
    await syncMessages(token);
  }

  }
  
  syncRoomsFromServer(token, Config configData) async{
      ChatRoomsModel data = await ChatRepostory().getChatRoomList();
      if(data.rooms != null){
        List<ChatRooms> myrooms = data.rooms as List<ChatRooms>;
          for (var room in myrooms) {
                  print(room.sId);
                }
      }
  }
  
  getUserInfo(token, Config configData) async{

  }
  
  syncMessages(token) {

  }
  
  Future<Config> getConfig(phone) async {
     final db = await SQLiteHelper().database;
     final results = await db.query('${Tables.CONFIG}' , where: "phone= ? " , whereArgs: [phone]);
     if(results.isEmpty){
      print("Creating new config");
      return await createNewConfig(db);
     }else{
      print("config found");
      return Config.fromJson(results[0]);
     }
     
  }

 Future<Config> createNewConfig(Database db) async{
    const tableName = Tables.CONFIG;
     final query = '''
      INSERT OR REPLACE INTO $tableName (phone, isSyncEnabled) VALUES (?, ?)
    ''';

     await db.execute(query, [
      phone,
      0,
    ]);
    return getConfig(phone);
  }

}
