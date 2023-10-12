import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/common_cubits/custom_error.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/api_data_source/repository/user/user_repository.dart';

part 'get_userdetails_state.dart';

class GetUserdetailsCubit extends Cubit<GetUserDetailsState> {
  GetUserdetailsCubit() : super(GetUserDetailsState.initial());

  void getUserDetailsCubit() async {
    emit(state.copyWith(status: GetUserDetailsStatus.loading));

    try {
      var data = await UserSerivce().getUserData();
      emit(state.copyWith(status: GetUserDetailsStatus.loaded, response: data));
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetUserDetailsStatus.error, error: e));
    }
  }
}
