// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'componants/on_boarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BriXColor Finder',
      home: OnBoarding(),
    );
  }
}
