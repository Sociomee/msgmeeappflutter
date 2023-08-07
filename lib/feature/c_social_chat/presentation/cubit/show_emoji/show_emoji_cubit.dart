import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_emoji_state.dart';

class ShowEmojiCubit extends Cubit<ShowEmojiState> {
  ShowEmojiCubit() : super(ShowEmojiState.initial());

  void diaplayEmoji(int index) {
    emit(state.copyWith(showEmoji: true, index: index));
  }

  void removeEmoji() {
    emit(state.copyWith(showEmoji: false, index: -1));
  }
}
