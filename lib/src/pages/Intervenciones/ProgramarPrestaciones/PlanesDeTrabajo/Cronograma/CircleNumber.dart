import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int number;
  final String month;

  const CircleNumber(this.number, this.month, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          month,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
