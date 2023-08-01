import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_boarding_app/blocs/settings_bloc/settings_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  context
                      .read<SettingsCubit>()
                      .updateLocale(locale: const Locale('en'));
                },
                child: const Text('English')),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<SettingsCubit>()
                      .updateLocale(locale: const Locale('ar'));
                },
                child: Text('العربية')),
          ],
        ),
      ),
    );
  }
}
