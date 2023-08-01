import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:on_boarding_app/blocs/settings_bloc/settings_cubit.dart';
import 'package:on_boarding_app/core/network/local/cache_helper.dart';
import 'package:on_boarding_app/screens/home_screen.dart';

import '/screens/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool hasUserBoarded = CacheHelper.getData(key: 'boarded') ?? false;
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit()..loadSetting(),
      // create: (context) {
      //   final settingsCubit = SettingsCubit();
      //   settingsCubit.loadSetting();
      //   return settingsCubit;
      // },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          //final settingsCubit = BlocProvider.of<SettingsCubit>(context);
          final settingsCubit = context.read<SettingsCubit>();
          return MaterialApp(
            title: 'Flutter Demo',
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: settingsCubit.locale,
            // localizationsDelegates: const [
            //   AppLocalizations.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: const [
            //   Locale('en'), // English
            //   Locale('ar'), // Arabic
            // ],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home:
                hasUserBoarded ? const HomeScreen() : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
