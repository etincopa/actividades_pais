import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BusyIndicator {
  static show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return const FullScreenLoader(); // Container
      },
    );
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  static showIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const FullScreenLoader(),
    );
  }

  static hideIndicator(BuildContext context) {
    hide(context);
  }
}

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(124, 105, 195, 255),
          ),
          //color: Colors.white.withOpacity(0.9),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 102, 255),
            ),
          ), // Center
        ),
        const SizedBox(
          height: 90,
        ),
      ]),
      onWillPop: () async => false,
    );
  }
}

/**
 * SAMPLE USE:
 * BusyIndicator.show(context);
 * BusyIndicator.hide(context);
 */
