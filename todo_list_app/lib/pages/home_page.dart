import 'package:flutter/material.dart';
import 'package:todo_list_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // list of todo tasks
  List toDoList = [
    ['Make Tutorial', true],
    ['Do Exercise', false],
    ['Buy Milk', false],
    ['Read Book', true],
    ['Walk the Dog', false],
    ['Clean the House', false],
    ['Plan Vacation', true],
  ];

  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: const Text('TO DO ...'),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}