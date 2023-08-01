import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:on_boarding_app/core/network/local/cache_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  late Locale _locale;

  Locale get locale => _locale;

  void loadSetting() {
    if (CacheHelper.contains(key: 'locale')) {
      final langCode = CacheHelper.getData(key: 'locale');
      _locale = Locale(langCode);
    } else {
      final systemBasedLocale = Platform.localeName.contains('ar')
          ? const Locale('ar')
          : const Locale('en');
      _locale = systemBasedLocale;
    }
    emit(SettingsLoadedState());
  }

  void updateLocale({required Locale locale}) {
    if (locale.languageCode == _locale.languageCode) return;

    _locale = locale;

    emit(SettingsChangedState());

    CacheHelper.setData(key: 'locale', value: _locale.languageCode);
    // CacheHelper.setData(
    //     key: 'locale',
    //     value: jsonEncode({
    //       'langCode': _locale.languageCode,
    //       'countryCode': _locale.countryCode,
    //     }));
  }
}
