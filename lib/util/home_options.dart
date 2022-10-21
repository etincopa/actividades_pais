import 'package:flutter/material.dart';

class HomeOptions {
  const HomeOptions({
    required this.code,
    required this.name,
    this.types = const [],
    required this.image,
    required this.color,
  });

  final Color color;
  final String image;
  final String code;
  final String name;
  final List<String> types;
}
