import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/app_settings_cubit.dart';
import 'package:todos_app/models/AppSettings.dart';
import 'package:todos_app/views/my_home_page.dart';

import 'blocs/todos_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettings>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Todo App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: state.useMaterial3,
            brightness: state.themeBrightness
          ),
          home: BlocProvider(
              create: (_) => TodosCubit(),
              child: const MyHomePage()),
        );
      }
    );
  }
}