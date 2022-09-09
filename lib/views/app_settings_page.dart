import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/app_settings_cubit.dart';
import 'package:todos_app/models/AppSettings.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Use Material 3'),
                BlocBuilder<AppSettingsCubit, AppSettings>(
                  builder: (context, state) {
                    return Switch(value: state.useMaterial3, onChanged: (value) => context.read<AppSettingsCubit>().changeMaterial3Usage(value));
                  }
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark theme'),
                BlocBuilder<AppSettingsCubit, AppSettings>(
                  builder: (context, state) {
                    return Switch(value: state.themeBrightness == Brightness.dark ? true : false, onChanged: (value){
                      context.read<AppSettingsCubit>().changeThemeBrightness(value ? Brightness.dark : Brightness.light);
                    });
                  }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
