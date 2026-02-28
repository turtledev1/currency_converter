import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/screens/camera/text_recognizer_view.dart';
import 'package:currency_converter/screens/home/converter_cubit.dart';
import 'package:currency_converter/screens/home/converter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
      builder: (context, state) {
        double conversionRate = 1.0;
        String targetCurrencySymbol = '\$';
        String sourceCurrencyCode = 'USD';
        String targetCurrencyCode = 'USD';

        if (state is ConverterLoaded) {
          final sourceRate = state.rates.rates[state.sourceCurrency.code] ?? 1.0;
          final targetRate = state.rates.rates[state.targetCurrency.code] ?? 1.0;
          conversionRate = targetRate / sourceRate;
          targetCurrencySymbol = state.targetCurrency.symbol;
          sourceCurrencyCode = state.sourceCurrency.code;
          targetCurrencyCode = state.targetCurrency.code;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Camera'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.pushNamed(RouteNames.settings),
              ),
            ],
          ),
          body: TextRecognizerView(
            conversionRate: conversionRate,
            targetCurrencySymbol: targetCurrencySymbol,
            sourceCurrencyCode: sourceCurrencyCode,
            targetCurrencyCode: targetCurrencyCode,
          ),
        );
      },
    );
  }
}
