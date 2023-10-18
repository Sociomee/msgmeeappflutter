import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityState {
  final ConnectivityResult result;
  final bool isOnline;

  ConnectivityState(this.result, this.isOnline);
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit()
      : super(ConnectivityState(ConnectivityResult.none, false));

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    bool isOnline = false;
    try {
      final lookup = await InternetAddress.lookup('www.google.com');
      isOnline = lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    emit(ConnectivityState(result, isOnline));
  }
}
