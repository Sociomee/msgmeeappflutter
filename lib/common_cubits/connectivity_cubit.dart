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
    print("connectiviet status ${result}");
    bool isOnline = false;
    try {
     if(result != ConnectivityResult.none){
       final lookup = await InternetAddress.lookup('www.google.com');
        print("lookup result ${lookup.length > 0}");
        isOnline = lookup.length > 0;
     }else{
      isOnline = false;
     }
    } on SocketException catch (_) {
      isOnline = false;
    }
    emit(ConnectivityState(result, isOnline));
  }
}
