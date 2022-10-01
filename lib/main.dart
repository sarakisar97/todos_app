import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/app_settings_cubit.dart';

import 'app.dart';
import 'blocs/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(BlocProvider(create: (_) => AppSettingsCubit(), child: const App()));
}
