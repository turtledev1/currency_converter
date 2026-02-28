import 'package:currency_converter/datasources/exchange_rate_service.dart';
import 'package:currency_converter/datasources/local_storage_service.dart';
import 'package:currency_converter/injection.dart';
import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/screens/home/converter_cubit.dart';
import 'package:currency_converter/screens/settings/settings_cubit.dart';
import 'package:currency_converter/screens/settings/settings_state.dart';
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
        BlocProvider(
          create: (context) => ConverterCubit(
            getIt<ExchangeRateService>(),
            context.read<SettingsCubit>(),
          )..initialize(),
        ),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
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
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.indigo,
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
