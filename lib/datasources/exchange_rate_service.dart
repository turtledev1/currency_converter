import 'dart:convert';

import 'package:currency_converter/datasources/local_storage_service.dart';
import 'package:currency_converter/datasources/models/currency.dart';
import 'package:currency_converter/datasources/models/exchange_rates.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class ExchangeRateService {
  ExchangeRateService(this._localStorageService);

  final LocalStorageService _localStorageService;

  static const _cacheKey = 'exchange_rates_cache';
  static const _apiUrl = 'https://v6.exchangerate-api.com/v6/9eb010d304be0f861755eb0a/latest/USD';

  /// Returns cached rates if available, fetches from API only when [forceRefresh]
  /// is true or no cache exists. Designed for offline-first usage while traveling.
  Future<ExchangeRates> getRates({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _loadCachedRates();
      if (cached != null) return cached;
    }

    try {
      return await _fetchAndCache();
    } catch (error) {
      // If fetch fails, fall back to cached data even when forceRefresh was requested
      final cached = await _loadCachedRates();
      if (cached != null) return cached;
      rethrow;
    }
  }

  double convert({
    required double amount,
    required Currency source,
    required Currency target,
    required ExchangeRates rates,
  }) {
    if (source == target) return amount;
    final sourceRate = rates.rates[source.code] ?? 1.0;
    final targetRate = rates.rates[target.code] ?? 1.0;
    return amount / sourceRate * targetRate;
  }

  Future<ExchangeRates> _fetchAndCache() async {
    final response = await http.get(Uri.parse(_apiUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch exchange rates: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final conversionRates = json['conversion_rates'] as Map<String, dynamic>;

    final exchangeRates = ExchangeRates(
      baseCode: json['base_code'] as String,
      rates: conversionRates.map((key, value) => MapEntry(key, (value as num).toDouble())),
      fetchedAt: DateTime.now(),
    );

    await _cacheRates(exchangeRates);
    return exchangeRates;
  }

  Future<ExchangeRates?> _loadCachedRates() async {
    final raw = await _localStorageService.read(_cacheKey);
    if (raw == null) return null;
    try {
      return ExchangeRates.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> _cacheRates(ExchangeRates rates) async {
    await _localStorageService.save(_cacheKey, jsonEncode(rates.toJson()));
  }
}
