import 'package:flutter/material.dart';
// import 'package:flutter_app_2/widgets/color_identifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:async';
import 'dart:io';
import '../widgets/home_screen_view.dart';
import '../widgets/camera_processor.dart';
import '../classes/brick.dart';

enum AppState { camera, crop, identify, done }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Brick> legoCache = [];
  late String resultString = "";
  late AppState state;
  var cameraProcessor = CameraProcessor();
  var view = HomeScreenView();

  @override
  void initState() {
    super.initState();
    state = AppState.camera;
  }

  void addBrick(Brick brick) {
    setState(() {
      legoCache.insert(0, brick); // Add brick to front of list
    });
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

  void processData(String brickName, String brickColor, double accuracy) {
    // If the accuracy is too low, don't process it and display it
    if (accuracy > 75.0) {
      setState(() {
        Brick brick = Brick(
            image: cameraProcessor.getImage(),
            name: brickName,
            color: brickColor, // todo: this is just a default value for testing
            accuracy: "${accuracy.toStringAsFixed(2)}%");
        resultString = brick.getNameResult();
        addBrick(brick);
      });
      return;
    }

    setState(() {
      resultString = "Brick could not be identified\nPlease try again";
    });
  }

  Future<void> retrieveLostData() async {}

  Container _takePictureButton() {
    return Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              onImageButtonPressed(ImageSource.camera, context);
              state = AppState.crop;
              setState(() {
                resultString = "";
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.camera,
                  size: 40,
                ),
                const SizedBox(
                    width: 20.0), // Add some space between the icon and text
                const Text(
                  'Take Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _cropPictureButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              onImageButtonPressed(ImageSource.camera, context);
              state = AppState.crop;
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              minimumSize: MaterialStateProperty.all<Size>(const Size(0, 60)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.camera,
                  size: 25,
                ),
                const SizedBox(
                    width: 20.0), // Add some space between the icon and text
                const Text(
                  'Retake Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              onCropButtonPressed();
              state = AppState.identify;
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrange),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              minimumSize: MaterialStateProperty.all<Size>(const Size(0, 60)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(
                  Icons.crop,
                  size: 25,
                ),
                const SizedBox(
                    width: 20.0), // Add some space between the icon and text
                const Text(
                  'Crop Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _identifyBrickButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                onImageButtonPressed(ImageSource.camera, context);
                state = AppState.crop;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(const Size(0, 60)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.camera,
                    size: 27,
                  ),
                  const SizedBox(
                      width: 10.0), // Add some space between the icon and text
                  const Text(
                    'Retake Photo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                final pred = await cameraProcessor.predictImage();
                final colorPred = await cameraProcessor.predictColor();
                String brickName = pred.key;
                String brickColor = colorPred.key;
                double accuracy = pred.value * 100;
                processData(brickName, brickColor, accuracy);
                //String color = await colorProcessor.predictColor();
                state = AppState.camera;
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(const Size(0, 60)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(
                    Icons.search,
                    size: 27,
                  ),
                  const SizedBox(
                      width: 10.0), // Add some space between the icon and text
                  const Text(
                    'Identify Brick',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  ElevatedButton _finishedButton() {
    return ElevatedButton(
      onPressed: () {
        state = AppState.camera;
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size(0, 50)),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.check,
            size: 40,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            'Finish',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container _actionButton() {
    if (state == AppState.camera) {
      return _takePictureButton();
    } else if (state == AppState.crop) {
      return Container(child: _cropPictureButton());
    } else if (state == AppState.identify) {
      return Container(
          child: _identifyBrickButton()); // Add color detection here
    } else {
      return Container(child: _finishedButton());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: view.helpButton(context),
        leadingWidth: 75,
        toolbarHeight: 75,
        title: view.appLogo(),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 232, 232),
        shadowColor: Colors.black,
        actions: [
          view.predictedCacheButton(context, legoCache),
          view.menuOptions(context),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cameraProcessor.displayImageOnScreen(retrieveLostData),
                Text(
                  resultString,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'WorkSans'),
                ),
              ],
            ),
          ),
          _actionButton(),
        ],
      ),
      // floatingActionButton: _actionButton(),
    );
  }
}
