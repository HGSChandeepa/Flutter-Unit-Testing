import 'package:flutter/material.dart';
import 'package:flutter_testing/counter.dart';

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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Text(
              counter.count.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter.add();
                    });
                  },
                  child: const Text("add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      counter.sub();
                    });
                  },
                  child: const Text("sub"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
