// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Screen that allows users to take a picture using the passed in camera
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializedControllerFuture;
  bool flash = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.veryHigh,
    );

    _initializedControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      FutureBuilder<void>(
        future: _initializedControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // if future complete, display preview
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CameraPreview(_controller));
          } else {
            // else, show spinner
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      Positioned(
          bottom: 0.0,
          child: Container(
              color: Colors.black38,
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _controller.setFlashMode(FlashMode.always)
                              : _controller.setFlashMode(FlashMode.off);
                        },
                        icon: flash
                            ? Icon(Icons.flash_on)
                            : Icon(Icons.flash_off),
                        color: Color(0xFFb3b3b3),
                        splashColor: Color(0xFF8a8a8a),
                        iconSize: 24,
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            await _initializedControllerFuture;
                            final image = await _controller.takePicture();
                            if (!mounted) return;
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayPictureScreen(
                                  imagePath: image.path,
                                ),
                              ),
                            );
                          } catch (e) {
                            // print(e);
                          }
                        },
                        icon: Icon(Icons.camera_alt),
                        color: Color(0xFFb3b3b3),
                        iconSize: 24,
                      ),
                    ],
                  )
                ],
              )))
    ]));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
        backgroundColor: Color(0xFFbebebe),
      ),
      // The image is stored as a file on the device
      // since we know the filePath, we can display that image
      // Important: we can use this to push it to the server (if necessary)
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
