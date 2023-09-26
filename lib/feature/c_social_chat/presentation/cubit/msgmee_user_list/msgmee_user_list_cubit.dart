import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/repository/user/user_repository.dart';

import '../../../../../common_cubits/custom_error.dart';

part 'msgmee_user_list_state.dart';

class MsgmeeUserListCubit extends Cubit<MsgmeeUserListState> {
  MsgmeeUserListCubit() : super(MsgmeeUserListState.initial());

  Future<void> getMsgmeeUsersList() async {
    try {
      emit(state.copyWith(status: ChatHeadStatus.loading));
      var res = await UserSerivce().getFriendList(10, '');
      emit(state.copyWith(status: ChatHeadStatus.loaded, msgmeeUserList: res));
    } on CustomError catch (e) {
      emit(state.copyWith(status: ChatHeadStatus.error, error: e));
    }
  }
}
