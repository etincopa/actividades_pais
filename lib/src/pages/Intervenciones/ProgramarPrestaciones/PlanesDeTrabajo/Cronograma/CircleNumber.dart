import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int number;
  final String month;

  CircleNumber(this.number, this.month);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          month,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(
              number.toString(),
              style: TextStyle(
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
