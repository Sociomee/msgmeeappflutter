import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/otp_model.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/auth/auth_repository.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit() : super(OtpVerifyState.initial());

  Future<void> verifyUserOtp(String phone, String otp) async {
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      emit(state.copyWith(status: OtpVerifyStatus.loading));
      var res = await auth.verifyOtp(phone, otp);
      if (res.success == true && res.status == 200) {
        emit(state.copyWith(status: OtpVerifyStatus.loaded));
      } else {
        emit(state.copyWith(status: OtpVerifyStatus.error));
      }
      log('response from cubit -->${res.status}');
    } on CustomError catch (e) {
      emit(state.copyWith(status: OtpVerifyStatus.error, error: e));
    }
  }
}
