import 'package:dio/dio.dart';
import 'package:todos_app/network/end_points.dart';
import 'package:todos_app/network/network_service.dart';

import '../models/todo.dart';

class TodosRepository{

  final NetworkService _networkService;

  TodosRepository(this._networkService);

  Future<List<Todo>> getTodos() async {
    final Response response = await _networkService.get(EndPoints.getPosts);
    return (response.data as List).map((e) => Todo.fromJson(e)).toList();
  }
}