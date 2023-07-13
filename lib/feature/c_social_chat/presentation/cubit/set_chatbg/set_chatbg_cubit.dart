import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../pages/chat_theme/widget/chat_bg_type.dart';

part 'set_chatbg_state.dart';

class SetChatbgCubit extends Cubit<SetChatbgState> {
  SetChatbgCubit() : super(SetChatbgState.initial());

  getChatBg(dynamic bg, ChatBgType type) {
    emit(state.copyWith(bgType: type, bgContent: bg));
  }

  chooseType(ChatBgType type) {
    emit(state.copyWith(bgType: type));
  }
  
}
