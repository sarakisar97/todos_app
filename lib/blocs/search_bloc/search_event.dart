part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class OnChanged extends SearchEvent{
  final String key;

  OnChanged(this.key);

  @override
  List<Object?> get props => [key];
}
