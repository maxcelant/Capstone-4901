
  // Future<void> _cropImage() async {
  //   if (_imageFileList != null) {
  //     final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: _imageFileList![0].path,
  //       compressFormat: ImageCompressFormat.jpg,
  //       compressQuality: 100,
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         IOSUiSettings(
  //           title: 'Cropper',
  //         ),
  //         WebUiSettings(
  //           context: context,
  //           presentStyle: CropperPresentStyle.dialog,
  //           boundary: const CroppieBoundary(
  //             width: 520,
  //             height: 520,
  //           ),
  //           viewPort:
  //               const CroppieViewPort(width: 480, height: 480, type: 'circle'),
  //           enableExif: true,
  //           enableZoom: true,
  //           showZoomer: true,
  //         ),
  //       ],
  //     );
  //     if (croppedFile != null) {
  //       setState(() {
  //         _croppedFile = croppedFile as File?;
  //         state = AppState.cropped;
  //       });
  //     }
  //   }
  // }