import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
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
}
