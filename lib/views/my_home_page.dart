import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/search_bloc/search_bloc.dart';
import 'package:todos_app/injection_container.dart';
import 'package:todos_app/views/app_settings_page.dart';
import 'package:todos_app/views/search_page.dart';
import 'package:todos_app/views/todo_card_page.dart';
import '../blocs/todos_cubit/todos_cubit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        leading: BlocBuilder<TodosCubit, TodosState>(
          buildWhen: (previous, current) => !(previous is TodosLoadSuccess && current is TodosLoadSuccess),
          builder: (context, state){
            if(state is TodosLoadSuccess){
              return IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider(
                  create: (_) => getIt<SearchBloc>(param1: state.todos),
                  child: const SearchPage()))), icon: const Icon(Icons.search),);
            }
            return const SizedBox.shrink();
          },
        ),
        actions: [
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppSettingsPage())), icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<TodosCubit, TodosState>(
          listenWhen: (previous, current) => current is TodosLoadSuccess && current.todos.length == 5,
          listener: (BuildContext context, state) {
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text('Todos Alert'),
                    content: const Text('Todos count = 5'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
                    ],
                  );
                }
            );
          },
          builder: (BuildContext context, state) {
            if(state is TodosLoadSuccess){
              return RefreshIndicator(
                onRefresh: context.read<TodosCubit>().getTodos,
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection direction){
                          context.read<TodosCubit>().deleteTodo(state.todos[index].id);
                        },
                        child: Card(
                          child: ListTile(
                            leading: Text(state.todos[index].id.toString()),
                            title: Text(state.todos[index].title),
                            subtitle: Text(state.todos[index].description),
                            trailing: IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(
                                  value: context.read<TodosCubit>(),
                                  child: TodoCardPage(todo: state.todos[index]))));
                            }, icon: const Icon(Icons.edit),),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.todos.length
                ),
              );
            }
            else if(state is TodosLoadFailure){
              return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red)));
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
      floatingActionButton: BlocBuilder<TodosCubit, TodosState>(
        buildWhen: (previous, current) => !(previous is TodosLoadSuccess && current is TodosLoadSuccess),
        builder: (context, state){
          if(state is TodosLoadSuccess){
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(
                    value: context.read<TodosCubit>(),
                    child: const TodoCardPage())));
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}