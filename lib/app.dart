import 'package:currency_converter/datasources/local_storage_service.dart';
import 'package:currency_converter/injection.dart';
import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/settings/settings_cubit.dart';
import 'package:currency_converter/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = getIt<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(getIt<LocalStorageService>()),
        ),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          // After the settings are loaded, leave the splash screen and navigate to the home screen
          if (state is SettingsLoaded) {
            _router.goNamed(RouteNames.home);
          }
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final themeMode = state is SettingsUpdated ? state.settings.theme : ThemeMode.system;

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Currency Converter',
              themeMode: themeMode,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.dark,
                ),
              ),
              routerConfig: _router,
            );
          },
        ),
      ),
    );
  }
}
