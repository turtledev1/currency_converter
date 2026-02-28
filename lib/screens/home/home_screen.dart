import 'package:currency_converter/datasources/models/currency.dart';
import 'package:currency_converter/routing/route_names.dart';
import 'package:currency_converter/screens/home/converter_cubit.dart';
import 'package:currency_converter/screens/home/converter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController(text: '1');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed(RouteNames.settings),
          ),
        ],
      ),
      body: BlocBuilder<ConverterCubit, ConverterState>(
        builder: (context, state) => switch (state) {
          ConverterError(:final message) => _ErrorView(
            message: message,
            onRetry: () => context.read<ConverterCubit>().initialize(),
          ),
          ConverterLoaded() => _ConverterBody(
            state: state,
            amountController: _amountController,
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RouteNames.camera),
        tooltip: 'Scan with camera',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Could not load exchange rates',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConverterBody extends StatelessWidget {
  const _ConverterBody({
    required this.state,
    required this.amountController,
    required this.colorScheme,
    required this.textTheme,
  });

  final ConverterLoaded state;
  final TextEditingController amountController;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConverterCubit>();
    final exchangeRate = state.rates.rates[state.targetCurrency.code] != null &&
            state.rates.rates[state.sourceCurrency.code] != null
        ? state.rates.rates[state.targetCurrency.code]! / state.rates.rates[state.sourceCurrency.code]!
        : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Source currency card
          Card(
            elevation: 0,
            color: colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('From', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            final amount = double.tryParse(value) ?? 0;
                            cubit.updateSourceAmount(amount);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      _CurrencySelector(
                        selectedCurrency: state.sourceCurrency,
                        onChanged: cubit.updateSourceCurrency,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Swap button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: IconButton.filled(
              onPressed: () {
                cubit.swapCurrencies();
                amountController.text = state.sourceAmount.toStringAsFixed(
                  state.sourceAmount.truncateToDouble() == state.sourceAmount ? 0 : 2,
                );
              },
              icon: const Icon(Icons.swap_vert),
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
          ),

          // Target currency card
          Card(
            elevation: 0,
            color: colorScheme.surfaceContainerHighest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.convertedAmount.toStringAsFixed(2),
                          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _CurrencySelector(
                        selectedCurrency: state.targetCurrency,
                        onChanged: cubit.updateTargetCurrency,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Exchange rate info
          Text(
            '1 ${state.sourceCurrency.code} = ${exchangeRate.toStringAsFixed(4)} ${state.targetCurrency.code}',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),

          const SizedBox(height: 8),

          // Last updated + refresh
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Updated ${_formatTimeSince(state.lastUpdated)}',
                style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
              ),
              IconButton(
                onPressed: () => cubit.refreshRates(),
                icon: Icon(Icons.refresh, size: 18, color: colorScheme.outline),
                tooltip: 'Refresh rates',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeSince(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) return 'just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    return '${difference.inDays}d ago';
  }
}

class _CurrencySelector extends StatelessWidget {
  const _CurrencySelector({required this.selectedCurrency, required this.onChanged});

  final Currency selectedCurrency;
  final ValueChanged<Currency> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _showCurrencyPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedCurrency.flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              selectedCurrency.code,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, size: 20, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet<Currency>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Currency',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: Currency.values.length,
                itemBuilder: (_, index) {
                  final currency = Currency.values[index];
                  final isSelected = currency == selectedCurrency;
                  return ListTile(
                    leading: Text(currency.flag, style: const TextStyle(fontSize: 24)),
                    title: Text(currency.code, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(currency.displayName),
                    trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                    selected: isSelected,
                    onTap: () {
                      Navigator.pop(sheetContext, currency);
                      onChanged(currency);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
