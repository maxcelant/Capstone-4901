import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import '../widgets/home_screen_ui.dart';
import '../widgets/camera_processor.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var homeScreenUI = HomeScreenUI();
  var cameraProcessor = CameraProcessor();

  Future<void> _onImageButtonPressed(
      ImageSource source, BuildContext? context) async {
    final XFile? pickedFile = await cameraProcessor.pickImage(source);
    setState(() {
      cameraProcessor.setImageFileListFromFile(pickedFile);
    });
  }

  // Retrieves lost images and updates file list accordingly
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await cameraProcessor.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          cameraProcessor.setImageFileListFromFile(response.file);
        } else {
          cameraProcessor.setImageFileListFromList(response.files);
        }
      });
    } else {
      cameraProcessor.setRetrieveDataError(response.exception!.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: homeScreenUI.helpButton(context),
        leadingWidth: 75,
        toolbarHeight: 100,
        title: homeScreenUI.appLogo(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          homeScreenUI.menuOptions(context),
        ],
      ),
      body: cameraProcessor.displayImageOnScreen(retrieveLostData),
      floatingActionButton:
          homeScreenUI.takeImageButton(_onImageButtonPressed, context),
    );
  }
}
