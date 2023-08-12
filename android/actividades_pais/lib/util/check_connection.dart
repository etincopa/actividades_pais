import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnection {
  /// Returns `true` si existe conexion a  internet
  static Future<bool> isOnline(String type) async {
    bool isOnline = false;
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      isOnline = isConnected;
      var typeConnectivity = await (Connectivity().checkConnectivity());
      if (type != '') {
        switch (type) {
          case 'WIFI':
            if (typeConnectivity == ConnectivityResult.wifi) {
              print('Wifi Connect');
              isOnline = true;
            }
            break;
          case 'MOBILE':
            if (typeConnectivity == ConnectivityResult.mobile) {
              print('Mobile Connect');
              isOnline = true;
            }
            break;
          case 'ALL':
            if (typeConnectivity == ConnectivityResult.wifi ||
                typeConnectivity == ConnectivityResult.mobile) {
              print('Mobile/Wifi Connect');
              isOnline = true;
            }
            break;
          default:
            isOnline = false;
        }
      }

      if (isOnline) {
        isOnline = await _checkStatus(typeConnectivity);
      }
      return isOnline;
    }

    print('No internet :(');
    return false;
  }

  static Future<bool> _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }

    return isOnline;
  }

  /// Returns `true` si existe conexion a  internet y la conezion es por wifi.
  static Future<bool> isOnlineWifi() async {
    return await isOnline('WIFI');
  }

  static Future<bool> isOnlineMobile() async {
    return await isOnline('MOBILE');
  }

  static Future<bool> isOnlineWifiMobile() async {
    return await isOnline('ALL');
  }
}
