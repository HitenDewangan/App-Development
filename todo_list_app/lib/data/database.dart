import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {

  List toDoList = [];
  
  //  reference our box
  final _myBox = Hive.box('mybox');

  //  run this method if this is the first time ever opening the app
  void createInitialData() {
    toDoList = [
      ['Do Exercise', false],
      ['Buy Milk', false],
      ['Read Book', false],
    ];
  }

  //  load the data from the database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //  update the database
  void updateDataBase() {
    _myBox.put('TODOLIST', toDoList);
  }


}