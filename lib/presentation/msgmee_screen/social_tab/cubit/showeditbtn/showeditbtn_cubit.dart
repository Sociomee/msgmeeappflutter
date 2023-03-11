import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'showeditbtn_state.dart';

class ShoweditbtnCubit extends Cubit<ShoweditbtnState> {
  ShoweditbtnCubit() : super(ShoweditbtnState.initial());

  showdialog() {
    emit(state.copyWith(show: !state.show));
  }
}
