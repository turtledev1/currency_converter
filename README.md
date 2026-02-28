# Currency Converter

A Flutter currency converter app with two conversion modes: a traditional text-field converter and a live camera mode that uses Google ML Kit text recognition to detect prices and convert them in real-time.

## Features

- **Text-field converter** — Enter an amount and convert between any two supported currencies
- **Live camera mode** — Point your camera at a price tag or receipt and see the converted amount overlaid in real-time via OCR (Google ML Kit)
- **18 supported currencies** — USD, EUR, GBP, JPY, CAD, AUD, CHF, CNY, INR, KRW, MXN, BRL, SEK, NOK, NZD, SGD, HKD, THB
- **Offline-first** — Cached exchange rates allow conversions without a network connection
- **Settings** — Configurable theme and default source/target currency preferences

## Screenshots

<!-- TODO: Add screenshots -->

## Getting Started

### Prerequisites

- Flutter SDK (Dart ^3.8.1)
- iOS: Xcode (for iOS simulator/device builds)
- Android: Android Studio / Android SDK

### Installation

```bash
# Clone the repository
git clone <repo-url>
cd currency_converter

# Install dependencies
flutter pub get

# Run code generation (required before first run)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Architecture

| Layer | Technology |
|-------|-----------|
| State management | BLoC / Cubit (`flutter_bloc`) |
| Routing | GoRouter |
| Dependency injection | GetIt + Injectable |
| Data models | Freezed + JSON Serializable |
| Local storage | SharedPreferences |
| OCR | Google ML Kit Text Recognition |
| Exchange rates | [ExchangeRate API](https://open.er-api.com/) (USD-based) |

Cross-currency conversion is calculated as: `amount / rates[source] * rates[target]`.

## Project Structure

```
lib/
├── datasources/          # Services and data models
│   ├── models/           # Currency enum, exchange rates, settings (Freezed)
│   ├── exchange_rate_service.dart
│   └── local_storage_service.dart
├── routing/              # GoRouter configuration and route names
├── screens/
│   ├── home/             # Text-field converter (ConverterCubit)
│   ├── camera/           # Live OCR camera mode
│   ├── settings/         # Theme and currency preferences (SettingsCubit)
│   └── splash_screen.dart
├── app.dart              # Root widget with MultiBlocProvider
├── injection.dart        # GetIt / Injectable setup
└── main.dart             # Entry point
```

## Development

```bash
# Static analysis
flutter analyze

# Run tests
flutter test

# Code generation (after modifying @freezed, @injectable, @JsonSerializable, or @module files)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation during development
dart run build_runner watch --delete-conflicting-outputs
```

## License

This project is for personal use.
