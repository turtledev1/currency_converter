import 'dart:convert';

import 'package:currency_converter/datasources/local_storage_service.dart';
import 'package:currency_converter/datasources/models/settings.dart';
import 'package:currency_converter/screens/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._localStorageService) : super(const SettingsState.initial());

  final LocalStorageService _localStorageService;

  static const storageKey = 'settings';

  Settings get currentSettings {
    final currentState = state;
    if (currentState is SettingsUpdated) return currentState.settings;
    if (currentState is SettingsLoaded) return currentState.settings;
    return const Settings(theme: ThemeMode.system);
  }

  void loadSettings() {
    emit(const SettingsState.loading());
    _localStorageService.read(storageKey).then((settings) {
      if (settings == null) {
        emit(const SettingsState.loaded(settings: Settings(theme: ThemeMode.system)));
        emit(const SettingsState.updated(settings: Settings(theme: ThemeMode.system)));
        return;
      }

      final decodedSettings = Settings.fromJson(jsonDecode(settings));

      emit(SettingsState.loaded(settings: decodedSettings));
      emit(SettingsState.updated(settings: decodedSettings));
    });
  }

  void updateSettings(Settings settings) async {
    await _localStorageService.save(storageKey, jsonEncode(settings.toJson()));
    emit(SettingsState.updated(settings: settings));
  }
}
