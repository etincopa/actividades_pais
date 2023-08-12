import 'dart:async';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectionStatusModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectionSubscription;
  bool _isOnline = true;

  ConnectionStatusModel() {
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    try {
      // Sometimes the callback is called when we reconnect to wifi, but the internet is not really functional
      // This delay try to wait until we are really connected to internet
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;

        Fluttertoast.showToast(
            msg: "En red",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        _isOnline = false;
        Fluttertoast.showToast(
            msg: "Sin red",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }

    notifyListeners();
  }

  bool get isOnline => _isOnline;
  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
