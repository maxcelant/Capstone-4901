// ignore_for_file: prefer_const_constructors, unused_element
// import 'package:camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2/componants/home_screen.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras =
      await availableCameras(); // list of available cameras on device

  final firstCamera = cameras.first; // get first camera

  _cameras = await availableCameras();
  runApp(MaterialApp(
    home: HomeScreen(camera1: firstCamera),
  ));
}
