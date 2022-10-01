import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppSettings extends Equatable{
  final bool useMaterial3;
  final Brightness themeBrightness;

  const AppSettings(this.useMaterial3, this.themeBrightness);

  AppSettings copyWith({bool? useMaterial3, Brightness? themeBrightness}){
    return AppSettings(useMaterial3 ?? this.useMaterial3, themeBrightness ?? this.themeBrightness);
  }

  @override
  List<Object?> get props => [useMaterial3, themeBrightness];
}