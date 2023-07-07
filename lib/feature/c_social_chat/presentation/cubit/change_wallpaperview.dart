import 'package:bloc/bloc.dart';

class ChangeWallPaperView extends Cubit<bool> {
  ChangeWallPaperView() : super(false);

  changeView() {
    emit(!state);
  }
}
