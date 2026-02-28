import 'package:currency_converter/datasources/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    required ThemeMode theme,
    @Default(Currency.jpy) Currency sourceCurrency,
    @Default(Currency.cad) Currency targetCurrency,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}
