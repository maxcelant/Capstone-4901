import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';

class color_detection extends StatelessWidget {
  final String imagePath;

  const color_detection({required Key key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var xAxis = screenSize.width ~/ 2;
    var yAxis = screenSize.height ~/ 2;

    return ImagePixels(
      imageProvider: AssetImage(imagePath),
      builder: (context, img) =>
          Text("Image Color is ${img.pixelColorAt!(xAxis, yAxis)}"),
    );
  }
}
