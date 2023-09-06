import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/common_cubits/custom_error.dart';
import 'package:msgmee/data/model/interest_model.dart';
import 'package:msgmee/data/repository/datasets/datasets_repository.dart';

part 'interest_state.dart';

class InterestCubit extends Cubit<InterestState> {
  InterestCubit() : super(InterestState.initial());

  void getInterests() async {
    emit(state.copyWith(status: InterestStatus.loading));
    try {
      var data = await DataSets().getinterests();
      emit(state.copyWith(
        status: InterestStatus.loaded,
        response: data,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: InterestStatus.error, error: e));
    }
  }

  void getfilterdData(List<String> ids) async {
    emit(state.copyWith(status: InterestStatus.loading));
    try {
      var data = await DataSets().getinterests();

      for (var i = 0; i < ids.length; i++) {
        List<InterestData> filteredData = data.data!.where((e) {
          return ids.contains(e.sId);
        }).toList();
        emit(state.copyWith(
            status: InterestStatus.loaded, intersts: filteredData));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(status: InterestStatus.error, error: e));
    }
  }
}
