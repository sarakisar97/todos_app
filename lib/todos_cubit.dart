import 'package:bloc/bloc.dart';
import 'package:todos_app/todo.dart';

class TodosCubit extends Cubit<List<Todo>> {
  TodosCubit() : super(const [
    Todo(1, 'title 1', 'description 1'),
    Todo(2, 'title 2', 'description 2'),
    Todo(3, 'title 3', 'description 3'),
  ]);

  void addTodo(Todo todo){
    emit([...state, todo]);
  }
}