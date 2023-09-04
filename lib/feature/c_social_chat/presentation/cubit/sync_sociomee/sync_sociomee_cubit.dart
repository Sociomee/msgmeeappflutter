import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/common_cubits/custom_error.dart';
import 'package:msgmee/data/model/sync_model.dart';

import '../../../../../data/model/socimee_account_model.dart';
import '../../../../../data/repository/sync/sync_socimee_repository.dart';

part 'sync_sociomee_state.dart';

class SyncSociomeeCubit extends Cubit<SyncSociomeeState> {
  SyncSociomeeCubit() : super(SyncSociomeeState.initial());

  void syncSociomeeCubit(String loginId, String password) async {
    emit(state.copyWith(status: SyncSociomeeStatus.loading));
    try {
      var data = await SyncSocimeeService().syncSocimee(loginId, password);
      emit(state.copyWith(status: SyncSociomeeStatus.loaded, response: data));
    } catch (e) {
      log('message---->$e');
      throw Exception(e);
    }
  }

  void getsyncSocimeeCubit() async {
    emit(state.copyWith(status: SyncSociomeeStatus.loading));
    try {
      var data = await SyncSocimeeService().getSocimeeAccount();
      emit(state.copyWith(
          status: SyncSociomeeStatus.loaded, syncResponse: data));
    } catch (e) {
      log('message---->$e');
      throw Exception(e);
    }
  }
}
