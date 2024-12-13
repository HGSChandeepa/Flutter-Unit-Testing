import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_tute/models/todo_model.dart';

class TodoService {
  final CollectionReference _todoCollection;

  // Constructor with default Firestore instance, but allows for dependency injection
  TodoService({
    FirebaseFirestore? firebaseFirestore,
  }) : _todoCollection = (firebaseFirestore ?? FirebaseFirestore.instance)
            .collection('tasks');

  // Method to add a new task to the Firestore collection
  Future<void> addTask(String name) async {
    try {
      final task = Todo(
        id: '',
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isUpdated: false,
      );
      final Map<String, dynamic> data = task.toJson();
      await _todoCollection.add(data);
      print('Task added');
    } catch (e) {
      print('Error adding task: $e');
      rethrow; // Re-throw to allow error handling in tests
    }
  }

  // Method to get all the tasks from the Firestore collection
  Stream<List<Todo>> getTasks() {
    return _todoCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  // Method to update a task in the Firestore collection
  Future<void> updateTask(Todo task) async {
    try {
      final Map<String, dynamic> data = task.toJson();
      await _todoCollection.doc(task.id).update(data);
      print('Task updated');
    } catch (e) {
      print('Error updating task: $e');
      rethrow; // Re-throw to allow error handling in tests
    }
  }

  // Method to delete a task from the Firestore collection
  Future<void> deleteTask(String id) async {
    try {
      await _todoCollection.doc(id).delete();
      print('Task deleted');
    } catch (e) {
      print('Error deleting task: $e');
      rethrow; // Re-throw to allow error handling in tests
    }
  }
}
