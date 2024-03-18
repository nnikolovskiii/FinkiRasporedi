import 'package:flutter/material.dart';

import 'main2.dart';
import 'main3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Draggable Example',
      home: Stack(
        children: [
          const MyTable(),
          DraggableExample(
            // Pass the callback function to DraggableExample
            onStateChange: (renderBox) {
              // Find the nearest MyTableState ancestor and call its updateState method
              MyTable.of(context)?.updateTableState(renderBox);
            },
          ),
        ],
      ),
    );
  }
}



