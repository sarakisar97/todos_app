part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Todo> todos;

  SearchLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}
