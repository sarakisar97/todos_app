part of 'todos_cubit.dart';

abstract class TodosState extends Equatable {
  const TodosState();
}

class TodosInitial extends TodosState {
  @override
  List<Object> get props => [];
}
class TodosLoadInProgress extends TodosState {
  @override
  List<Object> get props => [];
}
class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccess(this.todos);
  @override
  List<Object> get props => [todos];
}
class TodosLoadFailure extends TodosState {
  final String errorMessage;

  const TodosLoadFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
