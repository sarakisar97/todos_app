part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Todo> todos;

  SearchLoaded(this.todos);
}
