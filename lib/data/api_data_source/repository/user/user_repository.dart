import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/api_data_source/repository/dio_provider.dart';
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/contact_model.dart';
import 'package:msgmee/data/sqlite_data_source/sqlite_helper.dart';

import '../../../../helper/local_data.dart';

class UserSerivce implements AbUserRepository {
  var apiService = ApiService();
  var localData = Localdata();
  @override
  Future<MsgmeeUserModel> getUserData() async {
    var token = await localData.readData('token');
    var phone = await localData.readData('phone');

    final response = await apiService.dio.post(
      '$mainbaseUrl/api/check-user-by-phone',
      data: {
        "phone": phone,
      },
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );

    if (response.statusCode == 200) {
      var res = MsgmeeUserModel.fromJson(response.data);
     // log('userId------>${res.user?.sId}');
      localData.storedata('socimeeId', res.user?.socioMeeId ?? '');
     // localData.storedata('socimeePassword', res.user!.password ?? '');
      localData.storedata('userId', res.user?.sId ?? '');
      return res;
    } else {
      throw Exception();
    }
  }

  Future<bool> updateTokenToServer(String deviceToken) async {
    var token = await localData.readData('token');
    var phone = await localData.readData('phone');

    final response = await apiService.dio.post(
      '$mainbaseUrl/api/update-firbase-token',
      data: {
        "phone": phone,
        "deviceToken" : deviceToken
      },
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );

    if (response.statusCode == 200) {
      
      return true;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MsgmeeUserList> getFriendList(int limit, String search) async {
    var token = await localData.readData('token');
    final response = await apiService.dio.post(
      '$mainbaseUrl/api/search',
      data: {
        "limit": limit,
        "search": search,
      },
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    // log('search result------------->${response.data}');
    if (response.statusCode == 200) {
      var res = MsgmeeUserList.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
  }

    @override
  Future<ContactModel> getContactList(List<String> contacts) async {
    var token = await localData.readData('token');
    final response = await apiService.dio.post(
      '$mainbaseUrl/api/filtercontact',
      data: {
        "contacts": contacts
      },
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    if (response.statusCode == 200) {
      var res = ContactModel.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
  }

  Future<User> getCounterPartData(String? userId) async{
       final db = await SQLiteHelper().database;
       var result =  await db.query(Tables.USER , where: "id=?" , whereArgs: [userId]);
       if(result.isEmpty){
         
       }else{
        User usr = User.fromJson(result[0]);
        return usr;
       }

      return User();

  }
}
