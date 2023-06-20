import 'package:bloc/bloc.dart';

class ShowLoaderCubit extends Cubit<bool> {
  ShowLoaderCubit() : super(false);
  showloader() {
    emit(!state);
  }
}
