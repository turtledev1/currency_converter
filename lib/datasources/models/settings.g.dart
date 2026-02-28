// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  theme: $enumDecode(_$ThemeModeEnumMap, json['theme']),
  sourceCurrency:
      $enumDecodeNullable(_$CurrencyEnumMap, json['sourceCurrency']) ??
      Currency.jpy,
  targetCurrency:
      $enumDecodeNullable(_$CurrencyEnumMap, json['targetCurrency']) ??
      Currency.cad,
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'sourceCurrency': _$CurrencyEnumMap[instance.sourceCurrency]!,
  'targetCurrency': _$CurrencyEnumMap[instance.targetCurrency]!,
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$CurrencyEnumMap = {
  Currency.usd: 'usd',
  Currency.eur: 'eur',
  Currency.gbp: 'gbp',
  Currency.jpy: 'jpy',
  Currency.cad: 'cad',
  Currency.aud: 'aud',
  Currency.chf: 'chf',
  Currency.cny: 'cny',
  Currency.inr: 'inr',
  Currency.krw: 'krw',
  Currency.mxn: 'mxn',
  Currency.brl: 'brl',
  Currency.sek: 'sek',
  Currency.nok: 'nok',
  Currency.nzd: 'nzd',
  Currency.sgd: 'sgd',
  Currency.hkd: 'hkd',
  Currency.thb: 'thb',
};
