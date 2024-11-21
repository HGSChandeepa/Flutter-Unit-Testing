import 'package:flutter/material.dart';
import 'package:flutter_testing/todo_app/models/todo_model.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onDelete;
  final Function(String) onEdit;
  final VoidCallback onRefresh;

  const TodoList({
    Key? key,
    required this.todos,
    required this.onDelete,
    required this.onRefresh,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  todo.title,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEdit(todo.id),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDelete(todo.id),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
