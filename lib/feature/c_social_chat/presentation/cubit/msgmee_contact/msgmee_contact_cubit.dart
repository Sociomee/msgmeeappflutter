import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/repository/contact/contact_repository.dart';

import '../../../../../common_cubits/custom_error.dart';

part 'msgmee_contact_state.dart';

class MsgmeeContactCubit extends Cubit<MsgmeeContactState> {
  MsgmeeContactCubit() : super(MsgmeeContactState.initial());

  Future<void> getMsgmeeContact() async {
    try {
      emit(state.copyWith(status: MsgmeeContactStatus.loading));
      var res = await ContactService().getContacts();
      if (res.success == true && res.status == 200) {
        emit(state.copyWith(status: MsgmeeContactStatus.loaded, response: res));
      } else {
        emit(state.copyWith(status: MsgmeeContactStatus.error));
      }
      log('response from cubit -->${res.status}');
    } on CustomError catch (e) {
      emit(state.copyWith(status: MsgmeeContactStatus.error, error: e));
    }
  }
}
