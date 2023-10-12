import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/api_data_source/repository/dio_provider.dart';

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
      log('userId------>${res.user!.sId}');
      localData.storedata('socimeeId', res.user!.socioMeeId ?? '');
      localData.storedata('socimeePassword', res.user!.password ?? '');
      localData.storedata('userId', res.user!.sId ?? '');
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

    if (response.statusCode == 200) {
      var res = MsgmeeUserList.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
  }
}
