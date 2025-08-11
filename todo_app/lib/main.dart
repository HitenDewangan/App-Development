import 'package:flutter/material.dart';
import 'package:todo_app/pages/first_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // static List<String> names = [
  //   'Alice', 'Bob', 'Charlie', 'David', 'Eve',
  //   'Frank', 'Grace', 'Heidi', 'Ivan', 'Judy',
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes:{
        '/firstpage': (context) => FirstPage(),
        '/homepage': (context) => HomePage(),
        '/settingspage': (context) => SettingsPage(),
      }
    );
  }
}