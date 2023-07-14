import 'package:bloc/bloc.dart';

class SyncWithSociomee extends Cubit<bool> {
  SyncWithSociomee() : super(false);

  void sync() {
    emit(true);
  }

  void initialState() {
    emit(false);
  }
}
