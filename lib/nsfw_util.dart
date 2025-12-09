import 'dart:io';

import 'package:nsfw_util/src/utils/asset_utils.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class NSFWUtil {
  late final Interpreter _interpreter;
  late final Tensor _inputTensor;
  late final Tensor _outputTensor;

  Future<void> initialize() async {
    final options = InterpreterOptions();

    if (Platform.isAndroid) {
      options.addDelegate(XNNPackDelegate());
    }

    if (Platform.isIOS) {
      options.addDelegate(GpuDelegate());
    }

    _interpreter = await Interpreter.fromAsset(Assets.model, options: options);

    _inputTensor = _interpreter.getInputTensors().first;
    _outputTensor = _interpreter.getOutputTensors().first;
  }
}
