import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/common_cubits/custom_error.dart';

import '../../../../../data/model/socimee_user_model.dart';
import '../../../../../data/api_data_source/repository/sociomee/sync_socimee_repository.dart';
import '../../../../../helper/local_data.dart';

part 'sync_sociomee_state.dart';

class SyncSociomeeCubit extends Cubit<SyncSociomeeState> {
  SyncSociomeeCubit() : super(SyncSociomeeState.initial());

  Future<void> syncSociomeeAc() async {
    emit(state.copyWith(status: SyncSociomeeStatus.loading));
    // Record the start time
    DateTime startTime = DateTime.now();
    try {
      int index = 0;
      bool apiresponse = true;
      int totalCount = 100;
      while (apiresponse) {
        var data = await SyncSocimeeService().syncSocimee(index);
        index++;
        apiresponse = data.next!;
        if (data.next == true) {
          await SyncSocimeeService().syncSocimee(index);
        } // Calculate and update the progress
        final progress = (index / totalCount);
        state._progressController.add(progress);
        emit(state.copyWith(
          status: SyncSociomeeStatus.loaded,
          processend: 1,
          isSocimeeAcSynced: data.status,
        )); // Calculate the time taken
      }
      DateTime endTime = DateTime.now();
      Duration duration = endTime.difference(startTime);

      log('Loading took ${duration.inSeconds} seconds');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> checkSocimeeCubit() async {
    emit(state.copyWith(
      checkStatus: CheckSociomeeStatus.loading,
    ));
    var phone = await Localdata().readData('phone');
    log('phone---->$phone');
    try {
      var data = await SyncSocimeeService().checkSocimeeAccount();
      emit(
        state.copyWith(
          checkStatus: CheckSociomeeStatus.loaded,
          syncResponse: data,
          phone: phone,
          socimeeAuthToken: data.data!.successResult!.authToken.toString(),
        ),
      );
    } catch (e) {
      log('getting error while syncing with sociomee $e');
    }
  }
}
