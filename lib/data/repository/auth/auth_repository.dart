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
}
