import 'dart:convert';

import 'package:currency_converter/datasources/local_storage_service.dart';
import 'package:currency_converter/datasources/settings.dart';
import 'package:currency_converter/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._localStorageService) : super(const SettingsState.initial());

  final LocalStorageService _localStorageService;
  
  static const storageKey = 'settings';

  void loadSettings() {
    emit(const SettingsState.loading());
    _localStorageService.read(storageKey).then((settings) {
      if (settings == null) {
        emit(const SettingsState.loaded(settings: Settings(theme: ThemeMode.system)));
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
