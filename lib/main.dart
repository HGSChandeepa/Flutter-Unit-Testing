import 'package:flutter/material.dart';
import 'package:flutter_testing/api_app/screens/post_screen.dart';
import 'package:flutter_testing/counter/counter.dart';
import 'package:flutter_testing/todo_app/screens/todo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PostScreen());
  }
}
