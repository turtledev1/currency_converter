// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) =>
    _Settings(theme: $enumDecode(_$ThemeModeEnumMap, json['theme']));

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'theme': _$ThemeModeEnumMap[instance.theme]!,
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
