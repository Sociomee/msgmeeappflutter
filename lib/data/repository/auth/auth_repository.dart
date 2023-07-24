import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/repositories.dart';

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
    try {
      final response = await dio.post('$baseUrl/auth/verify-otp', data: {
        "phone": phone,
        "deviceId": phone,
        "otp": otp,
      });
      log("response -->>${response.statusCode}");
      if (response.statusCode == 200) {
        print("data --->${response.data['success']}");
        return response.data['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createUser(String phone, String name) async {
    try {
      final response = await dio.post('$baseUrl/users/createUser', data: {
        "phone": phone,
        "__v": 0,
        "name": name,
        "profilePic": "pfp.pngs"
      });
      if (response.statusCode == 200) {
        return true;
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
