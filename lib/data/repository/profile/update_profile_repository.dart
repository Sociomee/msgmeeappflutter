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
  Future<MsgmeeUserModel> updateUser(File image, String name) async {
    log('image -->$image');
    FormData formData = FormData.fromMap({
      "firstName": name,
      'profilePic': await MultipartFile.fromFile(image.path)
    });
    var token = await localData.readData('token');
    log('token from local storage-->$token');
    final response = await dio.patch(
      '$baseUrl/users/update',
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('update profile response-->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception("Getting Error");
    }
  }

  @override
  Future<MsgmeeUserModel> getUserDetails() async {
    var token = await localData.readData('token');
    var userId = await await localData.readData('userId');
    var response = await dio.get(
      '$baseUrl/users/$userId',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );

    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception('Getting error');
    }
  }

  @override
  Future<MsgmeeUserModel> getUserDetailsByPhone(String phone) async {
    var token = await localData.readData('token');
    var response = await dio.get(
      '$baseUrl/users/detail-by-phone/+$phone',
      options: Options(headers: {
        "Authorization": "Bearer $token",
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
  Future<MsgmeeUserModel> updateBio(String bio) async {
    var token = await localData.readData('token');
    log('token from local storage-->$token');
    final response = await dio.patch(
      '$baseUrl/users/update',
      data: {"bio": bio},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('update profile bio response-->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MsgmeeUserModel> updateDOB(String dob) async {
    var token = await localData.readData('token');
    log('token from local storage-->$token');
    final response = await dio.patch(
      '$baseUrl/users/update',
      data: {"dob": dob},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('update profile dob response-->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MsgmeeUserModel> updateGender(String gender) async {
    var token = await localData.readData('token');
    final response = await dio.patch(
      '$baseUrl/users/update',
      data: {"gender": gender},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('update profile gender response-->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MsgmeeUserModel> updateInterest(List<String> interestId) async {
    var token = await localData.readData('token');
    final response = await dio.patch(
      '$baseUrl/users/update',
      data: {"interests": interestId},
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('update profile interest response-->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = MsgmeeUserModel.fromJson(res);
      return data;
    } else {
      throw Exception();
    }
  }

  // @override
  // Future updateUserName(String name) async {
  //   var token = await localData.readData('token');
  //   var userId = await await localData.readData('userId');
  //   log('token from local storage-->$token');
  //   log('userId from local storage-->$userId');
  //   final response = await dio.patch(
  //     '$baseUrl/users/update',
  //     data: {"firstName": name},
  //     options: Options(headers: {
  //       "Authorization": "Bearer $token",
  //     }),
  //   );
  //   log('update profile name response-->$response');
  //   if (response.statusCode == 200) {}
  // }
}
