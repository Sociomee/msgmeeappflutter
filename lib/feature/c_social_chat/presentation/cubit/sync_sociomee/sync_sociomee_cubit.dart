import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/common_cubits/custom_error.dart';
import 'package:msgmee/data/model/sync_model.dart';

import '../../../../../data/model/socimee_user_model.dart';
import '../../../../../data/api_data_source/repository/sociomee/sync_socimee_repository.dart';
import '../../../../../helper/local_data.dart';

part 'sync_sociomee_state.dart';

class SyncSociomeeCubit extends Cubit<SyncSociomeeState> {
  SyncSociomeeCubit() : super(SyncSociomeeState.initial());

  void syncSociomeeAc() async {
    emit(state.copyWith(status: SyncSociomeeStatus.loading));

    try {
      int index = 0;
      bool apiresponse = true;
      while (apiresponse) {
        var data = await SyncSocimeeService().syncSocimee(index);
        index++;
        apiresponse = data.next!;
        if (data.next == true) {
          await SyncSocimeeService().syncSocimee(index);
        }
        emit(state.copyWith(
          status: SyncSociomeeStatus.loaded,
          response: data,
          isSocimeeAcSynced: data.status,
        ));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void checkSocimeeCubit() async {
    emit(state.copyWith(status: SyncSociomeeStatus.loading));
    var phone = await Localdata().readData('phone');
    log('phone---->$phone');
    try {
      var data = await SyncSocimeeService().checkSocimeeAccount();
      emit(state.copyWith(
        status: SyncSociomeeStatus.loaded,
        syncResponse: data,
        phone: phone,
        socimeeAuthToken: data.data!.successResult!.authToken.toString(),
      ));
    } catch (e) {
      throw Exception(e);
    }
  }
}
