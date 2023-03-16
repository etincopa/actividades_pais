import 'dart:async';

import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      showSimpleNotification(
        Text(connected ? 'ConnectOnline'.tr : 'ConnectOffline'.tr),
      );
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    opacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var cantidad = 0;
  void navigationPage() async {
    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    cantidad = abc.length;

    if (cantidad == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
      //PantallaInicio
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Monitor/backgroundLoadPage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(color: colorGB_01o27),
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                    opacity: opacity.value,
                    child: Image.asset('assets/Monitor/logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'DevelopByText'.tr),
                        TextSpan(
                          text: 'CompanyTag'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Home_Asis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePagePais();
  }
}
