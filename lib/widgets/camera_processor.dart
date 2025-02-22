import 'package:flutter/foundation.dart';
import 'package:flutter_app_2/classes/brick_identifier.dart';
import 'package:flutter_app_2/classes/color_finder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;

class CameraProcessor {
  File? _imageFile; // user's picture
  dynamic _pickImageError;
  bool isVideo = false;
  //String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();
  BrickIdentifier brickIdentifier = BrickIdentifier();
  ColorFinder colorFinder = ColorFinder();
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
    //_retrieveDataError = err;
  }

  Future<LostDataResponse> getLostData() async {
    return _picker.retrieveLostData();
  }

  // Checks for errors and returns widget tree that displays image
  Widget _previewImages() {
    if (_imageFile != null) {
      return Column(
        children: [
          Semantics(
            label: 'Image to identify',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(_imageFile as File),
            ),
          ),
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'WorkSans',
        ),
      );
    } else {
      return Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const Image(
            image: AssetImage('assets/unidentified_lego.png'),
          )
        ],
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
                    return Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                        const Image(
                          image: AssetImage('assets/unidentified_lego.png'),
                        )
                      ],
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
                      return Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          ),
                          const Image(
                            image: AssetImage('assets/unidentified_lego.png'),
                          )
                        ],
                      );
                    }
                }
              },
            )
          : handlePreview(),
    );
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
              toolbarColor: Colors.orange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
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
  Future<MapEntry<String, double>> predictImage() async {
    img.Image image = (await fileToImage()) as img.Image;
    return brickIdentifier.predict(image);
  }

  // Image color processor
  Future<MapEntry<String, double>> predictColor() async {
    img.Image image = (await fileToImage()) as img.Image;
    return colorFinder.predict(image);
  }
}
