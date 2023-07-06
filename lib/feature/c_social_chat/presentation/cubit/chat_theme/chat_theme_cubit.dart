import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

part 'chat_theme_state.dart';

class ChatThemeCubit extends Cubit<ChatThemeState> {
  ChatThemeCubit() : super(ChatThemeState.initial());

  changeTheme(Color deepColor, Color lightColor) {
    emit(state.copyWith(chatDeepColor: deepColor, chatLightColor: lightColor));
  }

  getInitalTheme() {
    emit(state.copyWith(
        chatDeepColor: AppColors.darkgreen,
        chatLightColor: AppColors.seconderyColor1));
  }

  selectTheme(int index) {
    emit(state.copyWith(selectedTheme: index));
  }
}
