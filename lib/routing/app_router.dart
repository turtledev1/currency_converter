import 'package:currency_converter/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @lazySingleton
  GoRouter router() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.home,
          builder: (context, state) => const Text('Home'),
        ),
        GoRoute(
          path: '/camera',
          name: RouteNames.camera,
          builder: (context, state) => const Text('Camera'),
        ),
        GoRoute(
          path: '/settings',
          name: RouteNames.settings,
          builder: (context, state) => const Text('Settings'),
        ),
      ],
    );
  }
}
