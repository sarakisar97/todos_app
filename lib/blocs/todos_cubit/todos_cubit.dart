import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/repositories/todos_repository.dart';

import '../../models/todo.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this._todosRepository) : super(TodosInitial()){
    getTodos();
  }

  final TodosRepository _todosRepository;

  Future<void> getTodos() async {
    emit(TodosLoadInProgress());
    try{
      final todos = await _todosRepository.getTodos();
      emit(TodosLoadSuccess(todos));
    }
    catch(e){
      emit(TodosLoadFailure(e.toString()));
    }

  }

  void addTodo(String title, String description){
    emit(TodosLoadSuccess([...(state as TodosLoadSuccess).todos, Todo((state as TodosLoadSuccess).todos.isNotEmpty ? (state as TodosLoadSuccess).todos.last.id + 1 : 1, title, description)]));
  }

  void editTodo(Todo newTodo){
    emit(TodosLoadSuccess([
      for(final todo in (state as TodosLoadSuccess).todos)
        if(todo.id == newTodo.id)
          newTodo
        else
          todo
    ]));
  }

  void deleteTodo(int id){
    emit(TodosLoadSuccess((state as TodosLoadSuccess).todos.where((element) => element.id != id).toList()));
  }
}
