import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/screens/camera/text_recognizer_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(RouteNames.settings);
            },
          ),
        ],
      ),
      body: TextRecognizerView(),
    );
  }
}
