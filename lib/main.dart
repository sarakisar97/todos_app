import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/app_settings_cubit.dart';
import 'package:todos_app/injection_container.dart';

import 'app.dart';
import 'blocs/app_bloc_observer.dart';

void main() {
  setup();
  Bloc.observer = AppBlocObserver();
  runApp(BlocProvider(create: (_) => getIt<AppSettingsCubit>(), child: const App()));
}
