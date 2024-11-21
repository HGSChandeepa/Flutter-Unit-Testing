import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/todo_app/models/todo_model.dart';

void main() {
  test('Todo model should create an instance correctly', () {
    final todo = Todo(id: '1', title: 'Test Todo');

    expect(todo.id, '1');
    expect(todo.title, 'Test Todo');
    expect(todo.isCompleted, false);

    final updatedTodo = todo.copyWith(title: 'Updated Title');

    expect(updatedTodo.title, 'Updated Title');
    expect(updatedTodo.id, '1');  
    expect(updatedTodo.isCompleted, false);
  });
}
