import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selectedchat_state.dart';

class SelectedchatCubit extends Cubit<SelectedchatState> {
  SelectedchatCubit() : super(SelectedchatState.initial());

  select(int index) {
    emit(state.copyWith(selectedchat: [...state.selectedchat, index]));
  }

  remove() {
    emit(state.copyWith(selectedchat: []));
  }

  starClicked() {
    emit(state.copyWith(starClicked: !state.starClicked));
  }

  muteClicked() {
    emit(state.copyWith(mute: !state.mute));
  }

  pinClicked() {
    emit(state.copyWith(pinned: !state.pinned));
  }
}
