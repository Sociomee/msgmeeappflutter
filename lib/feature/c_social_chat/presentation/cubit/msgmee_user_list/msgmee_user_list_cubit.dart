import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/repository/user/user_repository.dart';
import 'package:msgmee/helper/string_ext.dart';
import '../../../../../common_cubits/custom_error.dart';
import '../get_contact/get_contact_cubit.dart';
part 'msgmee_user_list_state.dart';

class MsgmeeUserListCubit extends Cubit<MsgmeeUserListState> {
  MsgmeeUserListCubit() : super(MsgmeeUserListState.initial());

  Future<void> getMsgmeeUsersList(
      List<PhoneBookUserModel> phonebookuser) async {
    try {
      emit(state.copyWith(status: MsgmeeUserListStatus.loading));
      var res = await UserSerivce().getFriendList(10, '');
      List<User> msgmeeUserList = res.users!;
      for (User msgmeeUser in msgmeeUserList) {
        for (PhoneBookUserModel phoneBookUser in phonebookuser) {
          if (msgmeeUser.phone == phoneBookUser.phone.toStandardFormat()) {
            msgmeeUser.fullName = phoneBookUser.name;
          }
          log('msgmeeuserlist---->${msgmeeUser.fullName}');
        }
      }

      emit(
        state.copyWith(
          status: MsgmeeUserListStatus.loaded,
          msgmeeUserList: MsgmeeUserList(
              limit: res.limit, search: res.search, users: msgmeeUserList),
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
    }
  }
}
