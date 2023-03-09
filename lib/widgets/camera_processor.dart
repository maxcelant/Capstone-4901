import 'package:flutter/foundation.dart';
import 'package:flutter_app_2/classes/brick_identifier.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'color_detection.dart';

class CameraProcessor {
  File? _imageFile; // user's picture
  dynamic _pickImageError;
  bool isVideo = false;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();
  BrickIdentifier brickIdentifier = BrickIdentifier();

  File? getImage() {
    return _imageFile;
  }

  void setImage(File? img) {
    _imageFile = img;
  }

  Future<XFile?> pickImage(source) async {
    return _picker.pickImage(source: source);
  }

  void setRetrieveDataError(String err) {
    _retrieveDataError = err;
  }

  Future<LostDataResponse> getLostData() async {
    return _picker.retrieveLostData();
  }

  // Checks for errors and returns widget tree that displays image
  Widget _previewImages() {
    // final Text? retrieveError = _getRetrieveErrorWidget();
    // if (retrieveError != null) {
    //   return retrieveError;
    // }
    if (_imageFile != null) {
      return Column(
        children: [
          Semantics(
            label: 'Image_picker_example_picked_images',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(_imageFile as File),
            ),
          ),
          color_detection(
              key: ValueKey<String>(_imageFile!.path),
              imagePath: _imageFile!.path),
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget handlePreview() {
    return _previewImages();
  }

  //End of working space ********************

  Center displayImageOnScreen(Future<void> Function() retrieveLostData) {
    return Center(
      child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.done:
                    return handlePreview();

                  default:
                    if (snapshot.hasError) {
                      return Text(
                        'Pick image/video error: ${snapshot.error}}',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    }
                }
              },
            )
          : handlePreview(),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  // Widget for cropping the image
  Future<CroppedFile?> getCroppedFile(BuildContext context) async {
    File? image = getImage();
    if (image != null) {
      return ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Color.fromARGB(255, 17, 85, 195),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
    }
    return null;
  }

  // Performs the decoding of File type to Image type
  Future<img.Image?> fileToImage() async {
    final bytes = await _imageFile!.readAsBytes();
    final img.Image? image = img.decodeImage(bytes);
    return image;
  }

  // Processes the file and then returns the name of the brick
  Future<String> predictImage() async {
    img.Image image = (await fileToImage()) as img.Image;
    return brickIdentifier.predict(image);
  }
}
