import 'package:flutter_bloc/flutter_bloc.dart';

class ShowContactTextField extends Cubit<bool> {
  ShowContactTextField() : super(false);
  void toggleValue() {
    emit(!state); // Toggle the boolean value and emit the new state
  }

  void getinitilstate() {
    emit(false);
  }
}
