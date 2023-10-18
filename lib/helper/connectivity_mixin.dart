import 'dart:async';
import 'dart:developer';
import 'dart:io';

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

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      log("connection result ${result.toString()}");
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
