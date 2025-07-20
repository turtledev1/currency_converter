import 'package:currency_converter/settings/settings_cubit.dart';
import 'package:currency_converter/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 24,
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

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Row(
                          children: [Icon(Icons.light_mode, size: 18), SizedBox(width: 4), Text('Light')],
                        ),
                        selected: themeMode == ThemeMode.light,
                        onSelected: (selected) {
                          if (selected) cubit.updateSettings(state.settings.copyWith(theme: ThemeMode.light));
                        },
                      ),
                      const SizedBox(width: 8),
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
