import 'package:camera/camera.dart';
import 'package:currency_converter/screens/camera/camera_view.dart';
import 'package:currency_converter/screens/camera/text_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({super.key});

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

    TextBlock? largestBlock = getOnlyBiggestBlockWithNumber(recognizedText);

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

  TextBlock? getOnlyBiggestBlockWithNumber(RecognizedText recognizedText) {
    final blocksWithNumberLine = recognizedText.blocks
        .where((block) => block.lines.length == 1 && block.lines.any((line) => RegExp(r'\d+').hasMatch(line.text)))
        .map((block) {
      final line = block.lines.first;
      // Remove all characters except digits, dots, and commas
      final cleanedText = line.text.replaceAll(RegExp(r'[^\d.,]'), '');
      final cleanedLine = TextLine(
        text: cleanedText,
        boundingBox: line.boundingBox,
        cornerPoints: line.cornerPoints,
        recognizedLanguages: line.recognizedLanguages,
        elements: line.elements,
        confidence: line.confidence,
        angle: line.angle,
      );
      return TextBlock(
        text: cleanedText,
        lines: [cleanedLine],
        boundingBox: block.boundingBox,
        cornerPoints: block.cornerPoints,
        recognizedLanguages: block.recognizedLanguages,
      );
    }).toList();
    final largestBlock = blocksWithNumberLine.isNotEmpty
        ? blocksWithNumberLine.reduce((a, b) {
            final aArea = (a.boundingBox.width) * (a.boundingBox.height);
            final bArea = (b.boundingBox.width) * (b.boundingBox.height);
            return aArea >= bArea ? a : b;
          })
        : null;

    return largestBlock;
  }
}
