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
          await dio.post('$baseUrl/auth/send-otp', data: {"phone": phone});
      log("response -->>${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<OtpModel> verifyOtp(String phone, String otp) async {
    var localdata = Localdata();

    final response = await dio.post('$baseUrl/auth/verify-otp', data: {
      "phone": phone,
      "otp": otp,
    });
    log("response-->>${response.data}");
    if (response.statusCode == 200) {
      var data = OtpModel.fromJson(response.data);
      localdata.storedata('token', data.data!.token!);
      localdata.storedata('userId', data.data!.userId!);
      localdata.storedata('userDeviceId', data.data!.userDeviceId!);
      localdata.storedata('deviceId', data.data!.deviceId!);
      log('res from repository ---> $data');
      return data;
    } else {
      return OtpModel.fromJson(response.data);
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
