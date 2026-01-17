import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { wifi, mobile, offline }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<NetworkStatus> _controller =
      StreamController<NetworkStatus>.broadcast();

  Stream<NetworkStatus> get stream => _controller.stream;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(_updateStatus);
    _checkInitial();
  }

  Future<void> _checkInitial() async {
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      _controller.add(NetworkStatus.wifi);
    } else if (results.contains(ConnectivityResult.mobile)) {
      _controller.add(NetworkStatus.mobile);
    } else {
      _controller.add(NetworkStatus.offline);
    }
  }

  void dispose() {
    _controller.close();
  }
}
