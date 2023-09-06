import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/repository/profile/update_profile_repository.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/model/msgmee_user_model.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileState.initial());

  void updateBio(String bio) async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));
    try {
      var data = await ProfileService().updateBio(bio);
      emit(state.copyWith(status: UpdateProfileStatus.loaded, reponse: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.error, error: e));
    }
  }

  void updateGender(String gender) async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));
    try {
      var data = await ProfileService().updateGender(gender);
      emit(state.copyWith(status: UpdateProfileStatus.loaded, reponse: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.error, error: e));
    }
  }

  void updateDOB(String dob) async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));
    try {
      var data = await ProfileService().updateDOB(dob);
      emit(state.copyWith(status: UpdateProfileStatus.loaded, reponse: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.error, error: e));
    }
  }

  void updateInterest(List<String> interests) async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));
    try {
      var data = await ProfileService().updateInterest(interests);
      emit(state.copyWith(status: UpdateProfileStatus.loaded, reponse: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.error, error: e));
    }
  }
}
