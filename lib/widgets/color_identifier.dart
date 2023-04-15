// Color identification attempt 2
// We are using palette_generator to try and Identify the color
// the new approach is throguh a function we call later in home_screen
import "package:flutter/material.dart";
import 'package:palette_generator/palette_generator.dart';
import 'package:collection/collection.dart';

class ImageColorName extends StatefulWidget {
  final String imagePath;

  const ImageColorName({required this.imagePath, required Key key})
      : super(key: key);
  @override
  ImageColorNameState createState() => ImageColorNameState();
}

class ImageColorNameState extends State<ImageColorName> {
  PaletteGenerator? _paletteGenerator;
  late Color _color;
  late String _colorName;

  @override
  void initState() {
    super.initState();
    _getColorFromImage();
  }

  Future<void> _getColorFromImage() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(AssetImage(widget.imagePath),
            size: const Size(200, 200), maximumColorCount: 10);
    setState(() {
      _paletteGenerator = paletteGenerator;
      _color = _paletteGenerator!.dominantColor!.color;
      _colorName = _getColorName(_color);
    });
  }

  String _getColorName(Color color) {
    // First logic attempt here. There are two ways to do this bit, refer to notebook

    MaterialColor? materialColor =
        Colors.primaries.firstWhereOrNull((element) => element == color);
    return materialColor != null ? materialColor.toString() : "Unknown Color";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Color Name: $_colorName",
      style: const TextStyle(fontSize: 20),
    );
  }
}
