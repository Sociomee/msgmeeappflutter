import 'dart:io';

import 'package:msgmee/data/model/otp_model.dart';

final String baseUrl = 'https://msgmee-node-docker-w0fh.onrender.com';

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<OtpModel> verifyOtp(String phone, String otp);
  Future<bool> createUser(String phone, String name, File image);
}

abstract class AbProfileRepository {
  Future<dynamic> updateUser(String userId, dynamic image);
}
