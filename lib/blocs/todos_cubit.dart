import 'package:bloc/bloc.dart';
import 'package:todos_app/models/todo.dart';

class TodosCubit extends Cubit<List<Todo>> {
  TodosCubit() : super(const [
    Todo(1, 'title 1', 'description 1'),
    Todo(2, 'title 2', 'description 2'),
    Todo(3, 'title 3', 'description 3'),
  ]);

  void addTodo(String title, String description){
    emit([...state, Todo(state.length + 1, title, description)]);
  }

  void editTodo(Todo myTodo){
    emit([
      for(final todo in state)
        if(todo.id == myTodo.id)
          Todo(todo.id, myTodo.title, myTodo.description)
      else
        todo
    ]);
  }

  void deleteTodo(int id){
    emit(state.where((element) => element.id != id).toList());
  }

}