import 'package:bloc/bloc.dart';

class SearchModeCubit extends Cubit<bool> {
  SearchModeCubit() : super(false);
  changeMode() {
    emit(!state);
  }
}
