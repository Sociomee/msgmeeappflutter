import 'package:dio/dio.dart';
import 'package:msgmee/data/model/otp_model.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/helper/local_data.dart';

class AuthService implements AuthRepository {
  final Dio dio;
  AuthService(this.dio);

  @override
  Future<bool> sendOtp(String phone) async {
    try {
      final response =
          await dio.post('$mainbaseUrl/api/send-otp', data: {"phone": phone});
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
    final response = await dio.post('$mainbaseUrl/api/verify-otp',
        data: {"phone": phone, "otp": otp});
    if (response.statusCode == 200 && response.data['status'] == true) {
      var res = OtpModel.fromJson(response.data);
      localdata.storedata('token', res.data!);
      localdata.storedata('phone', phone);
      return res;
    } else {
      var res = OtpErrorModel.fromJson(response.data);
      return res;
    }
  }
}
