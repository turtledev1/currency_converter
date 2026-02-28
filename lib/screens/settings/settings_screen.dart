import 'package:currency_converter/screens/settings/settings_cubit.dart';
import 'package:currency_converter/screens/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(),
            AppearanceRow(),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class AppearanceRow extends StatelessWidget {
  const AppearanceRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Appearance',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is! SettingsUpdated) {
              return const Center(child: CircularProgressIndicator());
            }
            final themeMode = state.settings.theme;
            final cubit = context.read<SettingsCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Row(
                    children: [Icon(Icons.settings, size: 18), SizedBox(width: 4), Text('System')],
                  ),
                  selected: themeMode == ThemeMode.system,
                  onSelected: (selected) {
                    if (selected) cubit.updateSettings(state.settings.copyWith(theme: ThemeMode.system));
                  },
                ),
                ChoiceChip(
                  label: const Row(
                    children: [Icon(Icons.light_mode, size: 18), SizedBox(width: 4), Text('Light')],
                  ),
                  selected: themeMode == ThemeMode.light,
                  onSelected: (selected) {
                    if (selected) cubit.updateSettings(state.settings.copyWith(theme: ThemeMode.light));
                  },
                ),
                ChoiceChip(
                  label: const Row(
                    children: [Icon(Icons.dark_mode, size: 18), SizedBox(width: 4), Text('Dark')],
                  ),
                  selected: themeMode == ThemeMode.dark,
                  onSelected: (selected) {
                    if (selected) cubit.updateSettings(state.settings.copyWith(theme: ThemeMode.dark));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
