import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:async';
import 'dart:io';

import '../widgets/home_screen_view.dart';
import '../widgets/camera_processor.dart';

enum AppState { camera, crop, identify, done }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppState state;
  var cameraProcessor = CameraProcessor();
  var view = HomeScreenView();

  @override
  void initState() {
    super.initState();
    state = AppState.camera;
  }

  Future<void> onImageButtonPressed(
      ImageSource source, BuildContext? context) async {
    final XFile? pickedFile = await cameraProcessor.pickImage(source);
    File file = File(pickedFile!.path);
    setState(() {
      cameraProcessor.setImage(file);
    });
  }

  // Crops the image (refactor later)
  Future<void> onCropButtonPressed() async {
    CroppedFile? croppedFile = await cameraProcessor.getCroppedFile(context);
    if (croppedFile != null) {
      File file = File(croppedFile.path);
      setState(() {
        cameraProcessor.setImage(file);
        cameraProcessor.handlePreview();
      });
    }
  }

  // TODO: figure this out
  //Retrieves lost images and updates file list accordingly
  Future<void> retrieveLostData() async {
    // final LostDataResponse response = await cameraProcessor.getLostData();
    // if (response.isEmpty) {
    //   return;
    // }
    // if (response.file != null) {
    //   setState(() {
    //     if (response.files == null) {
    //       cameraProcessor.setImageFileListFromFile(response.file);
    //     } else {
    //       cameraProcessor.setImageFileListFromList(response.files);
    //     }
    //   });
    // } else {
    //   cameraProcessor.setRetrieveDataError(response.exception!.code);
    // }
  }

  FloatingActionButton _actionButton() {
    if (state == AppState.camera) {
      state = AppState.crop;
      return FloatingActionButton(
        onPressed: () {
          onImageButtonPressed(ImageSource.camera, context);
        },
        heroTag: 'image2',
        tooltip: 'Take Photo',
        child: const Icon(Icons.camera),
      );
    } else if (state == AppState.crop) {
      state = AppState.identify;
      return FloatingActionButton(
        onPressed: () {
          onCropButtonPressed();
        },
        heroTag: 'image2',
        tooltip: 'Crop Photo',
        child: const Icon(Icons.crop),
      );
    } else if (state == AppState.identify) {
      state = AppState.camera;
      return FloatingActionButton(
        onPressed: () {
          cameraProcessor.predictImage();
        },
        heroTag: 'image2',
        tooltip: 'Identifying',
        child: const Icon(Icons.search),
      );
    } else {
      return FloatingActionButton(
        onPressed: () {},
        heroTag: 'image2',
        tooltip: 'Done',
        child: const Icon(Icons.check),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: view.helpButton(context),
        leadingWidth: 75,
        toolbarHeight: 100,
        title: view.appLogo(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          view.menuOptions(context),
        ],
      ),
      body: cameraProcessor.displayImageOnScreen(retrieveLostData),
      floatingActionButton: _actionButton(),
    );
  }
}
