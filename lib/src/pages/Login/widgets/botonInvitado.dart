import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class BotonInvitado extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonInvitado({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blue),
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: () => onPressed(),
      child: SizedBox(
        width: 250,
        height: 30,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
