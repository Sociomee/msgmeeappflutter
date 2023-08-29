import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/model/chat_head_model.dart';
import '../../../../../data/repository/chat_head/chat_head_repository.dart';

part 'chathead_state.dart';

class ChatHeadCubit extends Cubit<ChatHeadState> {
  ChatHeadCubit() : super(ChatHeadState.initial());

  Future<void> getMsgmeeChatHeads() async {
    try {
      emit(state.copyWith(status: ChatHeadStatus.loading));
      var res = await ChatHeadService().getChatHeadData();
      if (res.success == true && res.status == 200) {
        emit(state.copyWith(status: ChatHeadStatus.loaded, chatheads: res));
      } else {
        emit(state.copyWith(status: ChatHeadStatus.error));
      }
      log('response from cubit -->${res.status}');
    } on CustomError catch (e) {
      emit(state.copyWith(status: ChatHeadStatus.error, error: e));
    }
  }
}
