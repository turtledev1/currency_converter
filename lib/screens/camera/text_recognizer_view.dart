import 'package:camera/camera.dart';
import 'package:currency_converter/injection.dart';
import 'package:currency_converter/screens/camera/camera_image_processor.dart';
import 'package:currency_converter/screens/camera/camera_view.dart';
import 'package:currency_converter/screens/camera/text_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerView extends StatefulWidget {
  TextRecognizerView({super.key});

  final TextBlockProcessor _textBlockProcessor = getIt<TextBlockProcessor>();

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CameraView(
            customPaint: _customPaint,
            onImage: _processImage,
            initialCameraLensDirection: _cameraLensDirection,
            onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          ),
        ]),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);

    TextBlock? largestBlock = widget._textBlockProcessor.getRelevantTextBlock(recognizedText);

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null && largestBlock != null) {
      final painter = TextRecognizerPainter(
        largestBlock,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
