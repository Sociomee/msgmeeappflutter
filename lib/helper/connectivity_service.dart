import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectivityStream => _connectivityController.stream;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((result) {
      _connectivityController.add(_isConnected(result));
    });
  }

  bool _isConnected(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return _isConnected(connectivityResult);
  }

  void dispose() {
    _connectivityController.close();
  }
}
