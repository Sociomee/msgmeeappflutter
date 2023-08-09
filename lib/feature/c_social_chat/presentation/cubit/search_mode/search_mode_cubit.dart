import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_mode_state.dart';

class SearchModeCubit extends Cubit<SearchModeState> {
  SearchModeCubit() : super(SearchModeState.initial());

  changemsgSearchMode() {
    emit(state.copyWith(msgSearchMode: !state.msgSearchMode));
  }

  changeuserSearchMode() {
    emit(state.copyWith(chatuserSearchMode: !state.chatuserSearchMode));
  }

  closeMsgSearchMode() {
    emit(state.copyWith(chatuserSearchMode: false));
  }
}
