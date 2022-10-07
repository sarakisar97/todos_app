import 'package:get_it/get_it.dart';
import 'package:todos_app/blocs/app_settings_cubit.dart';
import 'package:todos_app/blocs/search_bloc/search_bloc.dart';
import 'package:todos_app/blocs/todos_cubit/todos_cubit.dart';
import 'package:todos_app/repositories/todos_repository.dart';

import 'models/todo.dart';
import 'network/network_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<NetworkService>(() => DioNetworkService());
  getIt.registerLazySingleton(() => TodosRepository(getIt()));

  getIt.registerFactory(() => TodosCubit(getIt()));
  getIt.registerFactoryParam<SearchBloc, List<Todo>, void>((todos, _) => SearchBloc(todos));
  getIt.registerFactory(() => AppSettingsCubit());
}