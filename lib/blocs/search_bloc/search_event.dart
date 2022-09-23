part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnChanged extends SearchEvent{
  final String key;

  OnChanged(this.key);
}
