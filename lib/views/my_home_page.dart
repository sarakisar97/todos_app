import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/views/app_settings_page.dart';

import '../blocs/todos_cubit.dart';
import '../models/todo.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
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
        onPressed: () => context.read<TodosCubit>().addTodo(const Todo(4, 'title 4', 'description 4')),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}