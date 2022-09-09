import 'dart:ui';

class AppSettings{
  final bool useMaterial3;
  final Brightness themeBrightness;

  const AppSettings(this.useMaterial3, this.themeBrightness);

  AppSettings copyWith({bool? useMaterial3, Brightness? themeBrightness}){
    return AppSettings(useMaterial3 ?? this.useMaterial3, themeBrightness ?? this.themeBrightness);
  }
}