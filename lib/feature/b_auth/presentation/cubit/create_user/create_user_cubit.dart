import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/auth/auth_repository.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserState.initial());

  Future<void> createUser(String phone, String name, File image) async {
    emit(state.copyWith(status: CreateUserStatus.loading));
    Dio dio = Dio();
    var auth = AuthService(dio);
    try {
      var res = await auth.createUser(phone, name, image);
      emit(state.copyWith(status: CreateUserStatus.loaded));
      log(res.toString());
    } on CustomError catch (e) {
      emit(state.copyWith(status: CreateUserStatus.error, error: e));
    }
  }
}
