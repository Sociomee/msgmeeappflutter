import 'package:bloc/bloc.dart';

class SyncMsgCubit extends Cubit<bool> {
  SyncMsgCubit() : super(false);

  syncmsg() {
    emit(true);
  }
}
