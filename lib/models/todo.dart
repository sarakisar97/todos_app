
import 'package:flutter/foundation.dart';

@immutable
class Todo{

  final int id;
  final String title;
  final String description;

  const Todo(this.id, this.title, this.description);
}