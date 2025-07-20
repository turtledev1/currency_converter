import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/screens/camera_screen.dart';
import 'package:currency_converter/screens/home_screen.dart';
import 'package:currency_converter/screens/settings_screen.dart';
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
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/camera',
          name: RouteNames.camera,
          builder: (context, state) => const CameraScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: RouteNames.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    );
  }
}
