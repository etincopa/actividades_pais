import 'package:flutter/material.dart';

class AlertQuestion extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPostivePressed;
  final VoidCallback onNegativePressed;

  const AlertQuestion({
    super.key,
    required this.title,
    required this.message,
    required this.onPostivePressed,
    required this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      actions: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onNegativePressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text("Cancelar"),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: onPostivePressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 26, 155, 86)),
                ),
                child: const Text("Continuar"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
