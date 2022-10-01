
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Todo extends Equatable{

  final int id;
  final String title;
  final String description;

  const Todo(this.id, this.title, this.description);
  
  factory Todo.fromJson(dynamic json){
    return Todo(json['id'], json['title'], json['body']);
  }

  @override
  List<Object?> get props => [id, title, description];
}