import 'package:firebase_flutter_tute/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test("Todo Model should create an instance correctly", () {
    final now = Timestamp.now();

    // Test creating Todo directly
    final todo = Todo(
      id: "1",
      name: "test todo",
      createdAt: now.toDate(),
      updatedAt: now.toDate(),
      isUpdated: false,
    );

    // Check direct instance creation
    expect(todo.id, "1");
    expect(todo.name, "test todo");
    expect(todo.createdAt, isA<DateTime>());
    expect(todo.updatedAt, isA<DateTime>());
    expect(todo.isUpdated, false);

    // Test creating Todo from JSON with Timestamp
    final todoFromJsonWithTimestamp = Todo.fromJson({
      "name": "test todo",
      "createdAt": now,
      "updatedAt": now,
      "isUpdated": false,
    }, "1");
    expect(todoFromJsonWithTimestamp.id, "1");
    expect(todoFromJsonWithTimestamp.createdAt, isA<DateTime>());
    expect(todoFromJsonWithTimestamp.updatedAt, isA<DateTime>());

    // Test toJson method converts DateTime to Timestamp
    final todoToJson = todo.toJson();
    expect(todoToJson["name"], "test todo");
    expect(todoToJson["createdAt"], isA<Timestamp>());
    expect(todoToJson["updatedAt"], isA<Timestamp>());
    expect(todoToJson["isUpdated"], false);
  });
}
