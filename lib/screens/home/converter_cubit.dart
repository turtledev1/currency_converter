import 'package:currency_converter/datasources/exchange_rate_service.dart';
import 'package:currency_converter/datasources/models/currency.dart';
import 'package:currency_converter/screens/home/converter_state.dart';
import 'package:currency_converter/screens/settings/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterCubit extends Cubit<ConverterState> {
  ConverterCubit(this._exchangeRateService, this._settingsCubit) : super(const ConverterState.initial());

  final ExchangeRateService _exchangeRateService;
  final SettingsCubit _settingsCubit;

  Future<void> initialize() async {
    emit(const ConverterState.loading());
    try {
      final rates = await _exchangeRateService.getRates();
      final settings = _settingsCubit.currentSettings;
      final convertedAmount = _exchangeRateService.convert(
        amount: 1.0,
        source: settings.sourceCurrency,
        target: settings.targetCurrency,
        rates: rates,
      );
      emit(ConverterState.loaded(
        rates: rates,
        sourceCurrency: settings.sourceCurrency,
        targetCurrency: settings.targetCurrency,
        sourceAmount: 1.0,
        convertedAmount: convertedAmount,
        lastUpdated: rates.fetchedAt,
      ));
    } catch (error) {
      emit(ConverterState.error(message: error.toString()));
    }
  }

  Future<void> refreshRates() async {
    final currentState = state;
    try {
      final rates = await _exchangeRateService.getRates(forceRefresh: true);
      if (currentState is ConverterLoaded) {
        final convertedAmount = _exchangeRateService.convert(
          amount: currentState.sourceAmount,
          source: currentState.sourceCurrency,
          target: currentState.targetCurrency,
          rates: rates,
        );
        emit(currentState.copyWith(
          rates: rates,
          convertedAmount: convertedAmount,
          lastUpdated: rates.fetchedAt,
        ));
      } else {
        await initialize();
      }
    } catch (error) {
      emit(ConverterState.error(message: error.toString()));
    }
  }

  void updateSourceAmount(double amount) {
    final currentState = state;
    if (currentState is! ConverterLoaded) return;
    final convertedAmount = _exchangeRateService.convert(
      amount: amount,
      source: currentState.sourceCurrency,
      target: currentState.targetCurrency,
      rates: currentState.rates,
    );
    emit(currentState.copyWith(sourceAmount: amount, convertedAmount: convertedAmount));
  }

  void updateSourceCurrency(Currency currency) {
    final currentState = state;
    if (currentState is! ConverterLoaded) return;
    final convertedAmount = _exchangeRateService.convert(
      amount: currentState.sourceAmount,
      source: currency,
      target: currentState.targetCurrency,
      rates: currentState.rates,
    );
    emit(currentState.copyWith(sourceCurrency: currency, convertedAmount: convertedAmount));
    _persistCurrencies(currency, currentState.targetCurrency);
  }

  void updateTargetCurrency(Currency currency) {
    final currentState = state;
    if (currentState is! ConverterLoaded) return;
    final convertedAmount = _exchangeRateService.convert(
      amount: currentState.sourceAmount,
      source: currentState.sourceCurrency,
      target: currency,
      rates: currentState.rates,
    );
    emit(currentState.copyWith(targetCurrency: currency, convertedAmount: convertedAmount));
    _persistCurrencies(currentState.sourceCurrency, currency);
  }

  void swapCurrencies() {
    final currentState = state;
    if (currentState is! ConverterLoaded) return;
    final convertedAmount = _exchangeRateService.convert(
      amount: currentState.sourceAmount,
      source: currentState.targetCurrency,
      target: currentState.sourceCurrency,
      rates: currentState.rates,
    );
    emit(currentState.copyWith(
      sourceCurrency: currentState.targetCurrency,
      targetCurrency: currentState.sourceCurrency,
      convertedAmount: convertedAmount,
    ));
    _persistCurrencies(currentState.targetCurrency, currentState.sourceCurrency);
  }

  void _persistCurrencies(Currency source, Currency target) {
    _settingsCubit.updateSettings(
      _settingsCubit.currentSettings.copyWith(sourceCurrency: source, targetCurrency: target),
    );
  }
}
