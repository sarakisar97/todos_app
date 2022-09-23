import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/todo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(List<Todo> initialTodos) : super(SearchLoaded(initialTodos)) {
    on<OnChanged>((event, emit) async {
      if(event.key.isNotEmpty){
        emit(SearchLoading());
        await Future.delayed(const Duration(seconds: 3));
        emit(SearchLoaded(initialTodos.where((element) => element.title.contains(event.key)).toList()));
      }
      else{
        emit(SearchLoaded(initialTodos));
      }
    }, transformer: (events, mapper){
      return events.debounceTime(const Duration(seconds: 1)).switchMap(mapper);
    });
  }
}
