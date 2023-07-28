import 'package:flutter/material.dart';

class HomeOptions {
  const HomeOptions({
    this.code,
    this.name,
    this.name2,
    this.name3,
    this.asubOption,
    this.types = const [],
    this.image,
    this.color,
    this.aOnPress = const [],
  });

  final Color? color;
  final String? image;
  final String? code;
  final String? name;
  final String? name2;
  final String? name3;
  final List<String>? types;
  final List<HomeOptions>? asubOption;
  final List<VoidCallback> aOnPress;
}
