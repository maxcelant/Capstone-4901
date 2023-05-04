import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart';
import 'package:collection/collection.dart';
import 'dart:math';

class ColorFinder {
  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  late TfLiteType _inputType;
  late TfLiteType _outputType;
  late List<int> _inputShape;
  late List<int> _outputShape;
  late List<String> labelColor;
  final String _labelsFileName = 'assets/color_label_2.txt';
  final int _labelsLength = 11;

  ColorFinder({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
    loadLabels();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('model_unquant.tflite',
          options: _interpreterOptions);
      //ignore_for_file: avoid_print
      print('Color Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _inputType = interpreter.getInputTensor(0).type;
      _outputType = interpreter.getOutputTensor(0).type;

      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, _outputType);
    } catch (e) {
      print(
          'Unable to create color interpreter, Caught Exception: ${e.toString()}');
    }
  }

  // A future that loads the labels from our color label file
  Future<void> loadLabels() async {
    labelColor = await FileUtil.loadLabels(_labelsFileName);
    if (labelColor.length == _labelsLength) {
      print('Color labels loaded successfully');
    } else {
      print('Unable to load color labels');
    }
  }

  TensorImage _preProcess() {
    int cropSize = min(_inputImage.height, _inputImage.width);
    ImageProcessor processor = ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.BILINEAR))
        .add(NormalizeOp(0.0, 255.0)) // Add normalization operation
        .build();
    _inputImage = processor.process(_inputImage);

    return _inputImage;
  }

  MapEntry<String, double> predict(Image image) {
    _inputImage = TensorImage(_inputType);
    _inputImage.loadImage(image);
    _inputImage = _preProcess();

    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());

    Map<String, double> labelProb = TensorLabel.fromList(
            labelColor, TensorProcessorBuilder().build().process(_outputBuffer))
        .getMapWithFloatValue();
    final predictedColor = getTopProbability(labelProb);

    print(predictedColor.key);

    return predictedColor;
  }

  void close() {
    interpreter.close();
  }
}

MapEntry<String, double> getTopProbability(Map<String, double> labelProb) {
  var pq = PriorityQueue<MapEntry<String, double>>(compare);
  pq.addAll(labelProb.entries);
  return pq.first;
}

int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) {
    return -1;
  } else if (e1.value == e2.value) {
    return 0;
  } else {
    return 1;
  }
}
