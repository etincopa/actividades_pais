import 'package:flutter/material.dart';

class CardType extends StatelessWidget {
  const CardType(this.label, {Key? key, this.large = false}) : super(key: key);

  final String label;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 12,
          vertical: large ? 6 : 4,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: large ? 12 : 8,
            height: 0.8,
            fontWeight: large ? FontWeight.bold : FontWeight.normal,
            color: const Color.fromARGB(255, 34, 34, 34),
          ),
        ),
      ),
    );
  }
}
