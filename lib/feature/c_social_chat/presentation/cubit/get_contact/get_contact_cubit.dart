import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../../helper/get_contacts.dart';

part 'get_contact_state.dart';

class GetContactCubit extends Cubit<GetContactState> {
  GetContactCubit() : super(GetContactState.initial());
  void getContactsCubit() async {
    emit(state.copyWith(status: GetContactStatus.loading));
    try {
      var contactdata = await getContactData();
      emit(state.copyWith(
          status: GetContactStatus.loaded, contacts: contactdata));
      log('response from cubit--->${state.contacts}');
    } catch (e) {
      emit(state.copyWith(status: GetContactStatus.error));
    }
  }
}
