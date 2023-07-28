import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
//import 'package:permission_handler/permission_handler.dart';

class CheckGeolocator {
  /*
  import 'package:geolocator/geolocator.dart';

  Future<List<Posicion>> verificacionpesmiso() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        //print("'Location permissions are permanently denied");
      } else {
        getLocation();
        //  print("GPS Location service is granted");
      }
    } else {
      var art = await getLocation();

      return art;
      //  print("GPS Location permission granted.");
    }
    return List.empty();
  }

  Future<List<Posicion>> getLocation() async {
    Posicion posicion = Posicion();
    List<Posicion> pst = [];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    pst = [];
    posicion.latitude = position.latitude;
    posicion.longitude = position.longitude;

    pst.add(posicion);

    return pst;
  }

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
  */
}
