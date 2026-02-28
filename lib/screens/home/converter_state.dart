import 'package:currency_converter/datasources/models/currency.dart';
import 'package:currency_converter/datasources/models/exchange_rates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'converter_state.freezed.dart';

@freezed
abstract class ConverterState with _$ConverterState {
  const factory ConverterState.initial() = ConverterInitial;
  const factory ConverterState.loading() = ConverterLoading;
  const factory ConverterState.loaded({
    required ExchangeRates rates,
    required Currency sourceCurrency,
    required Currency targetCurrency,
    required double sourceAmount,
    required double convertedAmount,
    required DateTime lastUpdated,
  }) = ConverterLoaded;
  const factory ConverterState.error({required String message}) = ConverterError;
}
