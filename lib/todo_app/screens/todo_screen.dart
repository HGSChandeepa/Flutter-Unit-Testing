// lib/screens/todo_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_testing/todo_app/models/todo_model.dart';
import '../services/todo_service.dart';
import '../widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _todos = _todoService.getTodos();
  }

  void _refreshTodos() {
    setState(() {
      _todos = _todoService.getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Todos Available'));
          } else {
            return TodoList(
              todos: snapshot.data!,
              onRefresh: _refreshTodos,
              onDelete: (id) async {
                await _todoService.deleteTodo(id);
                _refreshTodos();
              },
              onEdit: (String) {
                // Edit Todo logic here (e.g., show dialog)
                // For simplicity, we will just update the title.
                var updatedTodo = Todo(
                  id: String,
                  title: 'Updated Todo',
                );
                _todoService.updateTodo(updatedTodo);
                _refreshTodos();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add new Todo logic here (e.g., show dialog)
          // For simplicity, we will just add a static Todo.
          var newTodo = Todo(id: DateTime.now().toString(), title: 'New Todo');
          await _todoService.addTodo(newTodo);
          _refreshTodos();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
