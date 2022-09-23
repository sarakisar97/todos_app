import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/search_bloc/search_bloc.dart';
import 'package:todos_app/views/app_settings_page.dart';
import 'package:todos_app/views/search_page.dart';
import 'package:todos_app/views/todo_card_page.dart';

import '../blocs/todos_cubit.dart';
import '../models/todo.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider(
          create: (_) => SearchBloc(context.read<TodosCubit>().state),
            child: const SearchPage()))), icon: const Icon(Icons.search),),
        actions: [
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppSettingsPage())), icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<TodosCubit, List<Todo>>(
          listener: (BuildContext context, state) {
            if(state.length == 5){
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
            }
          },
          builder: (BuildContext context, state) {
            return ListView.separated(
                itemBuilder: (context, index){
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction){
                      context.read<TodosCubit>().deleteTodo(state[index].id);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text(state[index].id.toString()),
                        title: Text(state[index].title),
                        subtitle: Text(state[index].description),
                        trailing: IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(
                            value: context.read<TodosCubit>(),
                              child: TodoCardPage(todo: state[index]))));
                        }, icon: const Icon(Icons.edit),),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.length
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BlocProvider.value(
              value: context.read<TodosCubit>(),
              child: const TodoCardPage())));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}