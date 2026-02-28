import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:currency_converter/screens/camera/coordinates_translator.dart';
import 'package:currency_converter/screens/camera/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// Indigo-based palette for camera overlays
const _accentColor = Color(0xFF8C9EFF); // indigo accent 100
const _accentColorBright = Color(0xFFC5CAE9); // indigo 100
const _pillBackground = Color(0xE6303F9F); // indigo 700 at ~90% opacity
const _boundingBoxColor = Color(0xCC8C9EFF); // accent at 80%

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
    this.textBlock,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection, {
    required this.conversionRate,
    required this.targetCurrencySymbol,
  });

  final TextBlock textBlock;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final double conversionRate;
  final String targetCurrencySymbol;

  @override
  void paint(Canvas canvas, Size size) {
    _paintBoundingBox(size, canvas);
    _paintConversionResult(size, canvas);
  }

  void _paintBoundingBox(Size size, Canvas canvas) {
    final List<Offset> cornerPoints = _computeCornerPoints(size);

    // Semi-transparent fill inside the bounding box
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _accentColor.withValues(alpha: 0.1);
    final path = Path()..addPolygon(cornerPoints, true);
    canvas.drawPath(path, fillPaint);

    // Rounded-corner-style border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = _boundingBoxColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    cornerPoints.add(cornerPoints.first);
    canvas.drawPoints(PointMode.polygon, cornerPoints, borderPaint);

    // Detected text label above the bounding box
    final left = translateX(textBlock.boundingBox.left, size, imageSize, rotation, cameraLensDirection);
    final top = translateY(textBlock.boundingBox.top, size, imageSize, rotation, cameraLensDirection);
    final right = translateX(textBlock.boundingBox.right, size, imageSize, rotation, cameraLensDirection);

    final paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(textAlign: TextAlign.left, fontSize: 14, textDirection: TextDirection.ltr),
    );
    final labelBackground = Paint()..color = _pillBackground;
    paragraphBuilder.pushStyle(ui.TextStyle(
      color: _accentColorBright,
      background: labelBackground,
      fontWeight: FontWeight.bold,
    ));
    paragraphBuilder.addText(' ${textBlock.text} ');
    paragraphBuilder.pop();

    final paragraph = paragraphBuilder.build()..layout(ParagraphConstraints(width: (right - left).abs() + 24));
    final labelX = Platform.isAndroid && cameraLensDirection == CameraLensDirection.front ? right : left;
    canvas.drawParagraph(paragraph, Offset(labelX, top - 22));
  }

  void _paintConversionResult(Size size, Canvas canvas) {
    final resultText = _getConversionResult();

    // Measure the text first
    final textPainter = TextPainter(
      text: TextSpan(
        text: resultText,
        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    const horizontalPadding = 24.0;
    const verticalPadding = 12.0;
    final pillWidth = textPainter.width + horizontalPadding * 2;
    final pillHeight = textPainter.height + verticalPadding * 2;
    final pillX = (size.width - pillWidth) / 2;
    final pillY = size.height - pillHeight - 80;

    // Draw pill background
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(pillX, pillY, pillWidth, pillHeight),
      const Radius.circular(24),
    );
    canvas.drawRRect(pillRect, Paint()..color = _pillBackground);

    // Draw text centered in the pill
    textPainter.paint(canvas, Offset(pillX + horizontalPadding, pillY + verticalPadding));
  }

  String _getConversionResult() {
    final numberDetected = getNumberFromText(textBlock.text);
    final converted = numberDetected * conversionRate;
    return '$targetCurrencySymbol ${converted.toStringAsFixed(2)}';
  }

  List<Offset> _computeCornerPoints(Size size) {
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
    return cornerPoints;
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.textBlock != textBlock || oldDelegate.conversionRate != conversionRate;
  }
}
