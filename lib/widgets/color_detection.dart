import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';

class color_detection extends StatelessWidget {
  final String imagePath;
  final int xAxis;
  final int yAxis;

  const color_detection(
      {required Key key,
      required this.imagePath,
      required this.xAxis,
      required this.yAxis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    // var xAxis = screenSize.width ~/ 2;
    // var yAxis = screenSize.height ~/ 2;

    return ImagePixels(
        imageProvider: AssetImage(imagePath),
        builder: (context, img) {
          final color = img.pixelColorAt!(xAxis, yAxis);
          final colorName = getColorName(color);
          return Container(
            color: color,
            child: Center(
                child: Text(
              'Brick Color is $colorName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            )),
          );
        });
  }

  String getColorName(Color color) {
    if (color == Colors.black) {
      return 'Black';
    } else if (color == Colors.white) {
      return 'White';
    } else if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.green) {
      return 'Green';
    } else if (color == Colors.blue) {
      return 'Blue';
    } else {
      return color.toString();
    }
  }
}


// Text("Image Color is ${img.pixelColorAt!(xAxis, yAxis)}"),