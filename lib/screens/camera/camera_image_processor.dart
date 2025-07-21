import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';

@injectable
class TextBlockProcessor {
  /// Extracts the largest text block that contains a number from the recognized text.
  TextBlock? getRelevantTextBlock(RecognizedText recognizedText) {
    // TODO: check only in a specific area in the middle
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
        })
        .toList();
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
