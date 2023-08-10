import 'package:bloc/bloc.dart';

class ChooseLanguageCubit extends Cubit<String> {
  ChooseLanguageCubit() : super('English');

  void selectlanguage(String language) {
    emit(language);
  }
}
