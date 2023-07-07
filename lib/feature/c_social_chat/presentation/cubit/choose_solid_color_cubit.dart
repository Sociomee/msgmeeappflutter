// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class ChooseSolidColorCubit extends Cubit<Color> {
  ChooseSolidColorCubit() : super(AppColors.wallpaperColor1);

  void chooseColor(Color color) {
    emit(color);
  }
}
