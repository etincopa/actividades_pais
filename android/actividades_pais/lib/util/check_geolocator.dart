import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
//import 'package:permission_handler/permission_handler.dart';

class CheckGeolocator {
  /*Future<bool> check2() async {
    late LocationSettings locationSettings;

    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
      } else if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.location,
        ].request();

        if (PermissionStatus.permanentlyDenied ==
            statuses[Permission.location]) {
          openAppSettings();
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (await Permission.location.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      return false;
    }

    return true;
  }*/

  Future<bool> check() async {
    late LocationSettings locationSettings;
    if (defaultTargetPlatform == TargetPlatform.android) {
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
    } else {}

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ThrowCustom(
        type: 'E',
        msg: 'Los servicios de ubicación están deshabilitados.',
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw ThrowCustom(
          type: 'E',
          msg: 'Los permisos de ubicación están denegados.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw ThrowCustom(
        type: 'E',
        msg:
            'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos.',
      );
    }

    return true;
  }

  Future<List<Position>> getPosition() async {
    List<Position> aPosition = [];
    try {
      //bool isAutorice = await check2();
      bool isAutorice = await check();

      if (isAutorice) {
        aPosition.add(
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
          ),
        );
      }
    } catch (oError) {}

    return aPosition;
  }
}
