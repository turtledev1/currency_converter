import 'package:camera/camera.dart';
import 'package:currency_converter/injection.dart';
import 'package:currency_converter/screens/camera/camera_image_processor.dart';
import 'package:currency_converter/screens/camera/camera_view.dart';
import 'package:currency_converter/screens/camera/text_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({
    super.key,
    required this.conversionRate,
    required this.targetCurrencySymbol,
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
  });

  final double conversionRate;
  final String targetCurrencySymbol;
  final String sourceCurrencyCode;
  final String targetCurrencyCode;

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final _textBlockProcessor = getIt<TextBlockProcessor>();
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CameraView(
              customPaint: _customPaint,
              onImage: _processImage,
              initialCameraLensDirection: _cameraLensDirection,
              onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
            ),
            // Currency pair indicator
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.sourceCurrencyCode,
                        style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.arrow_forward, size: 16, color: colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        widget.targetCurrencyCode,
                        style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);

    TextBlock? largestBlock = _textBlockProcessor.getRelevantTextBlock(recognizedText);

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null && largestBlock != null) {
      final painter = TextRecognizerPainter(
        largestBlock,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
        conversionRate: widget.conversionRate,
        targetCurrencySymbol: widget.targetCurrencySymbol,
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
