part of 'settings_cubit.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsChangedState extends SettingsState {}

class SettingsLoadedState extends SettingsState {}
