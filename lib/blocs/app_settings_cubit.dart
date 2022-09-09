import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:todos_app/models/AppSettings.dart';

class AppSettingsCubit extends Cubit<AppSettings>{
  AppSettingsCubit() : super(const AppSettings(false, Brightness.light));

  void changeMaterial3Usage(bool useMaterial3){
    emit(state.copyWith(useMaterial3: useMaterial3));
  }

  void changeThemeBrightness(Brightness themeBrightness){
    emit(state.copyWith(themeBrightness: themeBrightness));
  }
}