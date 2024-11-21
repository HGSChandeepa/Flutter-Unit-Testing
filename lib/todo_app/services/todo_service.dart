import 'dart:convert';
import 'package:flutter_testing/todo_app/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  static const String _todoListKey = 'todoList';

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_todoListKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Todo(
              id: json['id'],
              title: json['title'],
              isCompleted: json['isCompleted'],
            ))
        .toList();
  }

  Future<void> addTodo(Todo todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await _saveTodos(todos);
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);

    if (index != -1) {
      todos[index] = updatedTodo;
      await _saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(todos
        .map((todo) => {
              'id': todo.id,
              'title': todo.title,
              'isCompleted': todo.isCompleted,
            })
        .toList());

    await prefs.setString(_todoListKey, jsonString);
  }
}
