import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/auth/auth_repository.dart';
import '../otp_send/otp_send_cubit.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserState.initial());

  Future<void> createUser(String phone, String name) async {
    emit(state.copyWith(status: LoginStatus.loading));
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      var res = await auth.createUser(phone, name);
      emit(state.copyWith(status: LoginStatus.loaded));
      print(res);
    } on CustomError catch (e) {
      emit(state.copyWith(status: LoginStatus.error, error: e));
    }
  }
}
