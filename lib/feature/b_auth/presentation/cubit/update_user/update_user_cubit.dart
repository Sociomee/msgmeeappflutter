import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/repository/profile/update_profile_repository.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/model/msgmee_user_model.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserState.initial());

  Future<void> updateUser(String name, File image) async {
    emit(state.copyWith(status: UpdateUserStatus.loading));

    try {
      var res = await ProfileService().updateUser(image, name);
      emit(state.copyWith(status: UpdateUserStatus.loaded, reponse: res));
      log(res.toString());
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateUserStatus.error, error: e));
    }
  }
}
