import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:currency_converter/screens/camera/coordinates_translator.dart';
import 'package:currency_converter/screens/camera/string_utils.dart';
import 'package:currency_converter/screens/camera/yen_to_cad_converter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(this.textBlock, this.imageSize, this.rotation, this.cameraLensDirection);

  final TextBlock textBlock;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    _paintRecognizedText(size, canvas);
    _paintYenConversionResult(size, canvas);
  }

  void _paintRecognizedText(Size size, Canvas canvas) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = const Color(0x99000000);

    final ParagraphBuilder builder = ParagraphBuilder(
      ParagraphStyle(textAlign: TextAlign.left, fontSize: 16, textDirection: TextDirection.ltr),
    );
    builder.pushStyle(ui.TextStyle(color: Colors.lightGreenAccent, background: background));
    builder.addText(textBlock.text);
    builder.pop();

    final left = translateX(textBlock.boundingBox.left, size, imageSize, rotation, cameraLensDirection);
    final top = translateY(textBlock.boundingBox.top, size, imageSize, rotation, cameraLensDirection);
    final right = translateX(textBlock.boundingBox.right, size, imageSize, rotation, cameraLensDirection);

    final List<Offset> cornerPoints = <Offset>[];
    for (final point in textBlock.cornerPoints) {
      double x = translateX(point.x.toDouble(), size, imageSize, rotation, cameraLensDirection);
      double y = translateY(point.y.toDouble(), size, imageSize, rotation, cameraLensDirection);

      if (Platform.isAndroid) {
        switch (cameraLensDirection) {
          case CameraLensDirection.front:
            switch (rotation) {
              case InputImageRotation.rotation0deg:
              case InputImageRotation.rotation90deg:
                break;
              case InputImageRotation.rotation180deg:
                x = size.width - x;
                y = size.height - y;
                break;
              case InputImageRotation.rotation270deg:
                x = translateX(point.y.toDouble(), size, imageSize, rotation, cameraLensDirection);
                y = size.height - translateY(point.x.toDouble(), size, imageSize, rotation, cameraLensDirection);
                break;
            }
            break;
          case CameraLensDirection.back:
            switch (rotation) {
              case InputImageRotation.rotation0deg:
              case InputImageRotation.rotation270deg:
                break;
              case InputImageRotation.rotation180deg:
                x = size.width - x;
                y = size.height - y;
                break;
              case InputImageRotation.rotation90deg:
                x = size.width - translateX(point.y.toDouble(), size, imageSize, rotation, cameraLensDirection);
                y = translateY(point.x.toDouble(), size, imageSize, rotation, cameraLensDirection);
                break;
            }
            break;
          case CameraLensDirection.external:
            break;
        }
      }

      cornerPoints.add(Offset(x, y));
    }

    // Add the first point to close the polygon
    cornerPoints.add(cornerPoints.first);
    canvas.drawPoints(PointMode.polygon, cornerPoints, paint);

    canvas.drawParagraph(
      builder.build()..layout(ParagraphConstraints(width: (right - left).abs())),
      Offset(Platform.isAndroid && cameraLensDirection == CameraLensDirection.front ? right : left, top),
    );
  }

  void _paintYenConversionResult(Size size, Canvas canvas) {
    final textSpan = TextSpan(
      text: _getYenToCadConversion(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      size.height - textPainter.height - 16,
    );
    textPainter.paint(canvas, textOffset);
  }

  String _getYenToCadConversion() {
    double numberDetected = getNumberFromText(textBlock.text);
    double cad = convertYenToCad(numberDetected);
    return '${cad.toStringAsFixed(2)}\$';
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.textBlock != textBlock;
  }
}
