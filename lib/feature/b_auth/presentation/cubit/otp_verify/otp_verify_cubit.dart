import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/otp_model.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/api_data_source/repository/auth/auth_repository.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit() : super(OtpVerifyState.initial());

  Future<void> verifyUserOtp(String phone, String otp) async {
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      emit(state.copyWith(status: OtpVerifyStatus.loading));
      var res = await auth.verifyOtp(phone, otp);

      if (res.status == true) {
        emit(state.copyWith(status: OtpVerifyStatus.loaded));
      } else if (res.status == false) {
        emit(state.copyWith(status: OtpVerifyStatus.error));
      }
      log('response from cubit -->${res}');
    } on CustomError catch (e) {
      emit(state.copyWith(status: OtpVerifyStatus.error, error: e));
    }
  }
}
