import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  ConnectivityCubit() : super(ConnectivityStatus.online);

  void startListening() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.offline);
      } else {
        emit(ConnectivityStatus.online);
      }
    });
  }
}
