import 'package:flutter/material.dart';

class InformmacionAplicativoPage extends StatelessWidget {
  const InformmacionAplicativoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 155.0,
            child: Image.asset(
              'assets/paislogo.png',
              height: 90.0,
              width: 300.0,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 200,
            child: Text(
                'Este Aplicativo fue desarrollado por el Programa Nacional Pais'),
          ),
        ]),
      ),
    );
  }
}
