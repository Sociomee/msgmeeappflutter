import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/auth/auth_repository.dart';

part 'otp_send_state.dart';

class OtpSendCubit extends Cubit<OtpSendState> {
  OtpSendCubit() : super(OtpSendState.initial());

  Future<void> sendOtp(String phone) async {
    emit(state.copyWith(status: LoginStatus.loading));
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      var res = await auth.sendOtp(phone);
      emit(state.copyWith(status: LoginStatus.loaded));
      print(res);
    } on CustomError catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e));
    }
  }
}
