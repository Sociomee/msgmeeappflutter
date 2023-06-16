import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'number_validation_state.dart';

class NumberValidationCubit extends Cubit<NumberValidationState> {
  NumberValidationCubit() : super(NumberValidationState.initial());

  void checkingValidation(String number) {
    if (number.isNotEmpty && number.length == 10) {
      emit(state.copyWith(isvalid: !state.isvalid));
    } else {
      emit(state.copyWith(isvalid: false));
    }
  }
}
