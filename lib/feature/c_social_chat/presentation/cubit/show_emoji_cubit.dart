// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowEmojiCubit extends Cubit<bool> {
  ShowEmojiCubit() : super(false);

  void diaplayEmoji() {
    emit(true);
  }

  void removeEmoji() {
    emit(false);
  }
}
