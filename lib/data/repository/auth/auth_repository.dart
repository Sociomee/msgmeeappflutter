import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:msgmee/data/repositories.dart';

import '../../../helper/get_device_id.dart';

class AuthService implements AuthRepository {
  final Dio dio;
  AuthService(this.dio);

  @override
  Future<bool> sendOtp(String phone) async {
    try {
      final response = await dio.post('$baseUrl/auth/send-otp', data: {
        "phone": phone,
      });
      log("response -->>${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyOtp(String phone, String otp) async {
    var deviceId = await getId();
    print(deviceId);
    try {
      final response = await dio.post('$baseUrl/auth/verify-otp', data: {
        "phone": phone,
        "otp": otp,
      });
      log("response-->>${response.data}");
      if (response.statusCode == 200) {
        FlutterSecureStorage storage = FlutterSecureStorage();
        storage.write(key: 'token', value: response.data['data']['token']);
        log('token-->${response.data['data']['token']}');
        return response.data['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createUser(String phone, String name, File image) async {
    try {
      // var formData =
      //     FormData.fromMap({'file': await MultipartFile.fromFile(image.path)});

      final response = await dio.post('$baseUrl/users',
          data: {"phone": phone, "name": name, "profilePic": "formData"});
      log('response--->${response.data}');
      log('image-->${await MultipartFile.fromFile(image.path)}');
      if (response.statusCode == 200) {
        return response.data['success'];
      } else {
        print(response);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
