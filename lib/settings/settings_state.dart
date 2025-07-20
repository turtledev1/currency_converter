import 'package:currency_converter/datasources/settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = SettingsInitial;
  const factory SettingsState.loading() = SettingsLoading;
  const factory SettingsState.loaded({required Settings settings}) = SettingsLoaded;
  const factory SettingsState.updated({required Settings settings}) = SettingsUpdated;
  const factory SettingsState.error(String message) = SettingsError;
}
