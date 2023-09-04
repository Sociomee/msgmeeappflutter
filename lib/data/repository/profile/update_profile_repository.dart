import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/helper/local_data.dart';

class ProfileService extends AbProfileRepository {
  Dio dio = Dio();
  var localData = Localdata();
  @override
  Future updateUser(String userId, File image, String name) async {
    log('image -->$image');
    FormData formData = FormData.fromMap({
      "userId": userId,
      "firstName": name,
      'profilePic':
          await MultipartFile.fromFile(image.path, filename: 'image.jpg')
    });
    var token = await localData.readData('token');
    log('token from local storage-->$token');
    final response = await dio.post(
      '$baseUrl/users/update',
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    log('update profile response-->$response');
    if (response.statusCode == 200) {}
  }

  @override
  Future getUserDetails() async {
    var token = await localData.readData('token');
    var userId = await await localData.readData('userId');
    var response = await dio.get(
      '$baseUrl/users/$userId',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('user details response----->>${response.data}');
    if (response.statusCode == 200) {}
  }

  @override
  Future<MsgmeeUserModel> getUserDetailsByPhone(String phone) async {
    var token = await localData.readData('token');
    var userId = await await localData.readData('userId');
    var response = await dio.get(
      '$baseUrl/users/detail-by-phone/+$phone',
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "userId": userId,
      }),
    );
    log('res----->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception('');
    }
  }

  @override
  Future updateUserName(String name) async {
    var token = await localData.readData('token');
    var userId = await await localData.readData('userId');
    log('token from local storage-->$token');
    log('userId from local storage-->$userId');
    final response = await dio.post(
      '$baseUrl/users/update',
      data: {"userId": userId, "firstName": name},
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "userId": userId,
      }),
    );
    log('update profile response-->$response');
    if (response.statusCode == 200) {}
  }
}
