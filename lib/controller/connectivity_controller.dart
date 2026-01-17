import 'dart:async';
import 'package:flutter/material.dart';
import '../service/connectivity_service.dart';

class ConnectivityController extends ChangeNotifier {
  final ConnectivityService service;
  late StreamSubscription _subscription;

  NetworkStatus _status = NetworkStatus.offline;
  NetworkStatus get status => _status;

  bool isOnline = false;
  bool isOffline = true;
  bool restored = false;

  ConnectivityController(this.service) {
    _subscription = service.stream.listen(_onStatusChanged);
  }

  void _onStatusChanged(NetworkStatus newStatus) {
    final wasOffline = _status == NetworkStatus.offline;

    _status = newStatus;
    isOffline = newStatus == NetworkStatus.offline;
    isOnline = !isOffline;
    restored = wasOffline && isOnline;

    notifyListeners(); 
  }

  bool get isWifi => _status == NetworkStatus.wifi;
  bool get isMobile => _status == NetworkStatus.mobile;

  @override
  void dispose() {
    _subscription.cancel();
    service.dispose();
    super.dispose();
  }
}
