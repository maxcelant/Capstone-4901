import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Brick {
  final File? image;
  final String name;
  final String color;
  final String accuracy;

  Brick(
      {required this.image,
      required this.name,
      required this.color,
      required this.accuracy});

  String getNameResult() {
    return "$name - $accuracy";
  }
}
