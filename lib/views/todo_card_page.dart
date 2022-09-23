import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/todos_cubit.dart';

import '../models/todo.dart';

class TodoCardPage extends StatelessWidget {
  const TodoCardPage({Key? key, this.todo}) : super(key: key);

  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? title;
    String? description;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: todo?.title,
                decoration: const InputDecoration(
                  label: Text('Title')
                ),
                validator: (value) => _todoValidator(value),
                onSaved: (value) => title = value,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: todo?.description,
                decoration: const InputDecoration(
                    label: Text('Description')
                ),
                validator: (value) => _todoValidator(value),
                onSaved: (value) => description = value,
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(onPressed: (){
                if(formKey.currentState!.validate()){
                  formKey.currentState!.save();
                  if(todo != null){
                    context.read<TodosCubit>().editTodo(Todo(todo!.id, title!, description!));
                  }
                  else{
                    context.read<TodosCubit>().addTodo(title!, description!);
                  }
                  Navigator.pop(context);
                }
              }, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  String? _todoValidator(String? value){
    if(value == null || value.isEmpty){
      return 'required';
    }
    else{
      return null;
    }
  }
}
