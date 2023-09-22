import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:msgmee/data/model/otp_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/helper/local_data.dart';

class AuthService implements AuthRepository {
  final Dio dio;
  AuthService(this.dio);

  @override
  Future<bool> sendOtp(String phone) async {
    try {
      final response =
          await dio.post('$baseUrl/api/send-otp', data: {"phone": phone});
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return response.data['status'];
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> verifyOtp(String phone, String otp) async {
    var localdata = Localdata();
    final response = await dio
        .post('$baseUrl/api/verify-otp', data: {"phone": phone, "otp": otp});
    log('response ----->>>${response.data['status']}');
    if (response.statusCode == 200 && response.data['status'] == true) {
      var res = OtpModel.fromJson(response.data);
      localdata.storedata('token', res.data!);
      return res;
    } else {
      var res = OtpErrorModel.fromJson(response.data);
      return res;
    }
  }

  @override
  Future<bool> createUser(String phone, String name, File image) async {
    try {
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
