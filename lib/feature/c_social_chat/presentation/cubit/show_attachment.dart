import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAttachment extends Cubit<bool> {
  ShowAttachment() : super(false);
  void toggleValue() {
    emit(!state);
  }

  void closeAttachment() {
    emit(false);
  }
}
