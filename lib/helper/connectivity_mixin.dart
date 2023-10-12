import 'package:connectivity_plus/connectivity_plus.dart';

mixin ConnectivityMixin {
  ConnectivityResult _previousConnectivity = ConnectivityResult.none;
  Stream<ConnectivityResult>? _connectivityStream;

  void initConnectivityListener() {
    _connectivityStream = Connectivity().onConnectivityChanged;
    _connectivityStream!.listen((connectivityResult) {
      if (connectivityResult != _previousConnectivity) {
        _previousConnectivity = connectivityResult;
        onConnectivityChanged(connectivityResult);
      }
    });
  }

  void onConnectivityChanged(ConnectivityResult connectivityResult) {
    // Implement this method in your host class to react to connectivity changes.
  }
}

class MyConnectionListener with ConnectivityMixin {
  MyConnectionListener() {
    initConnectivityListener();
  }

  @override
  void onConnectivityChanged(ConnectivityResult connectivityResult) {
    // Handle connectivity changes here.
    if (connectivityResult == ConnectivityResult.none) {
      // Connection is offline
      print("Offline");
    } else {
      // Connection is online
      print("Online");
    }
  }
}
