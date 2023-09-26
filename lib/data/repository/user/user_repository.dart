import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/data/repository/dio_provider.dart';

import '../../../helper/local_data.dart';

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
    log(response.data.toString());
    if (response.statusCode == 200) {
      var res = MsgmeeUserModel.fromJson(response.data);
      localData.storedata('socimeeId', res.user!.socioMeeId ?? '');
      localData.storedata('socimeePassword', res.user!.password ?? '');
      return res;
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
    log(response.data.toString());
    if (response.statusCode == 200) {
      var res = MsgmeeUserList.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
  }
}
