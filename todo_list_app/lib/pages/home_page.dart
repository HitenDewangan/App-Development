import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/data/database.dart';
import 'package:todo_list_app/util/dialog_box.dart';
import 'package:todo_list_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the Hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase tdb = ToDoDatabase();

  @override
  void initState() {
    
    //  if it's the first time opening the app, create initial data
    if (_myBox.get('TODOLIST') == null) {
      tdb.createInitialData();
    } else {
      //  load the data from the database
      tdb.loadData();
    }
  }

  // controller for text field
  final _controller = TextEditingController();

  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      tdb.toDoList[index][1] = !tdb.toDoList[index][1];
    });
    // update the database
    tdb.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
        );
      }
    );
  }

  // save new task
  void saveNewTask() {
    setState(() {
      tdb.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    // update the database
    tdb.updateDataBase();
  }

  // delete task
  void deleteTask(BuildContext context, int index) {
    setState(() {
      tdb.toDoList.removeAt(index);
    });
    // update the database
    tdb.updateDataBase();
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
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo[200],
      ),
      body: ListView.builder(
        itemCount: tdb.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: tdb.toDoList[index][0],
            taskCompleted: tdb.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTask(context, index),
          );
        },
      ),
    );
  }
}