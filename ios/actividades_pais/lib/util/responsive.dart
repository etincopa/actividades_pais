import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  late double _width, _heigth, _diagonal;

  double get width => _width;
  double get heigth => _heigth;
  double get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _heigth = size.height;

    // c2+ a2+02 => C= sqrt(a2+b2)

    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_heigth, 2));
  }

  double wp(double porcent) => _width * porcent / 100;
  double hp(double porcent) => _heigth * porcent / 100;
  double dp(double porcent) => _diagonal * porcent / 100;
}
