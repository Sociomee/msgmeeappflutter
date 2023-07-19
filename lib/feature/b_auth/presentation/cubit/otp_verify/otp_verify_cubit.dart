import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/auth/auth_repository.dart';
import '../otp_send/otp_send_cubit.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit() : super(OtpVerifyState.initial());

  Future<void> verifyUserOtp(String phone, String otp) async {
    emit(state.copyWith(status: LoginStatus.loading));
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      var res = await auth.verifyOtp(phone, otp);
      if (res) {
        emit(state.copyWith(status: LoginStatus.loaded));
      } else {
        emit(state.copyWith(status: LoginStatus.error));
      }
      print(res);
    } on CustomError catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e));
    }
  }
}
