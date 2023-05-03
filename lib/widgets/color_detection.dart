import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';

class ColorDetection extends StatelessWidget {
  final String imagePath;

  const ColorDetection({required Key key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var xAxis = screenSize.width ~/ 2;
    var yAxis = screenSize.height ~/ 2;

    return ImagePixels(
        imageProvider: AssetImage(imagePath),
        builder: (context, img) {
          final color = img.pixelColorAt!(xAxis, yAxis);
          // final colorName = getColorName(color);
          return Text('Lego color is: $color}');
        });
  }
}
