import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_flutter_tute/models/todo_model.dart';
import 'package:firebase_flutter_tute/services/todo_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late TodoService todoService;

  setUp(() {
    // Create a new instance of FakeFirebaseFirestore for each test
    firestore = FakeFirebaseFirestore();

    // Override the FirebaseFirestore instance in TodoService with our fake instance
    todoService = TodoService(firebaseFirestore: firestore);
  });

  group('TodoService', () {
    test('addTask should add a new task to Firestore', () async {
      // Arrange
      const taskName = 'Test Task';

      // Act
      await todoService.addTask(taskName);

      // Assert
      final querySnapshot = await firestore.collection('tasks').get();
      expect(querySnapshot.docs.length, 1);
      final addedTask = querySnapshot.docs.first;
      expect(addedTask.get('name'), taskName);
      expect(addedTask.get('isUpdated'), false);
    });

    test('getTasks should return a stream of tasks', () async {
      // Arrange
      // Add some test tasks directly to Firestore
      await firestore.collection('tasks').add({
        'name': 'Task 1',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isUpdated': false,
      });
      await firestore.collection('tasks').add({
        'name': 'Task 2',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isUpdated': false,
      });

      // Act
      final tasksStream = todoService.getTasks();

      // Assert
      final tasks = await tasksStream.first;
      expect(tasks.length, 2);
      expect(tasks[0].name, 'Task 1');
      expect(tasks[1].name, 'Task 2');
    });

    test('updateTask should update an existing task', () async {
      // Arrange
      // Add a task to Firestore first
      final docRef = await firestore.collection('tasks').add({
        'name': 'Original Task',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isUpdated': false,
      });

      // Create a Todo object to update
      final originalTask = Todo(
        id: docRef.id,
        name: 'Original Task',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isUpdated: false,
      );

      // Modify the task
      final updatedTask = Todo(
        id: docRef.id,
        name: 'Updated Task',
        createdAt: originalTask.createdAt,
        updatedAt: DateTime.now(),
        isUpdated: true,
      );

      // Act
      await todoService.updateTask(updatedTask);

      // Assert
      final updatedDoc =
          await firestore.collection('tasks').doc(docRef.id).get();
      expect(updatedDoc.get('name'), 'Updated Task');
      expect(updatedDoc.get('isUpdated'), true);
    });

    test('deleteTask should remove a task from Firestore', () async {
      // Arrange
      // Add a task to Firestore first
      final docRef = await firestore.collection('tasks').add({
        'name': 'Task to Delete',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isUpdated': false,
      });

      // Act
      await todoService.deleteTask(docRef.id);

      // Assert
      final querySnapshot = await firestore.collection('tasks').get();
      expect(querySnapshot.docs.length, 0);
    });
  });
}
