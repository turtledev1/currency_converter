import 'package:currency_converter/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.pushNamed(RouteNames.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Currency Converter!', style: Theme.of(context).textTheme.headlineLarge),
            FilledButton(
              onPressed: () {
                context.pushNamed(RouteNames.camera);
              },
              child: const Text('Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
