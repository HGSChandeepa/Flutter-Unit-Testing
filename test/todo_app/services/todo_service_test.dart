import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/todo_app/models/todo_model.dart';
import 'package:flutter_testing/todo_app/services/todo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure that SharedPreferences is mocked correctly before each test.
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('TodoService Tests', () {
    test('Add and retrieve todos', () async {
      final service = TodoService();

      // Create a new todo and add it.
      var newTodo = Todo(id: '1', title: 'Test Todo');
      await service.addTodo(newTodo);

      // Retrieve todos and verify.
      var todos = await service.getTodos();
      expect(todos.length, 1);
      expect(todos[0].title, newTodo.title);
    });

    test('Update an existing todo', () async {
      final service = TodoService();

      // Add initial todo.
      var newTodo = Todo(id: '1', title: 'Test Todo');
      await service.addTodo(newTodo);

      // Update the existing todo.
      var updatedTodo = newTodo.copyWith(title: 'Updated Title');
      await service.updateTodo(updatedTodo);

      // Retrieve todos and verify.
      var todos = await service.getTodos();
      expect(todos.length, 2);
      expect(todos[0].title, updatedTodo.title);
    });

    test('Delete a todo', () async {
      final service = TodoService();

      // Add initial todo.
      var newTodo = Todo(id: '1', title: 'Test Todo');
      await service.addTodo(newTodo);

      // Delete the existing todo.
      await service.deleteTodo(newTodo.id);

      // Retrieve todos and verify.
      var todos = await service.getTodos();
      expect(todos.length, 0);
    });
  });
}
