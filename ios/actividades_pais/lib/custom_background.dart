import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = Colors.white);
    canvas.drawRect(Rect.fromLTRB(width - (width / 3), 0, width, height),
        Paint()..color = color_02o27);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
