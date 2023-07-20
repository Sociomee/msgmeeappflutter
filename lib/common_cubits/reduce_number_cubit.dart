import 'package:bloc/bloc.dart';

class ReduceNumberCubit extends Cubit<int> {
  ReduceNumberCubit() : super(64);

  reduceNumber(int length) {
    emit(state - length);
  }
}
