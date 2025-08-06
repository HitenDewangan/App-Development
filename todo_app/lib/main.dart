import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold( // Using Scaffold to provide a basic material design layout
        backgroundColor: const Color.fromARGB(255, 79, 5, 163),
        appBar: AppBar(
          title: const Text('My beautiful app'),
          // text color
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 88, 88, 88),
          elevation: 0, // No shadow under the app bar
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Action for the menu button
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Action for the notifications button
              },
            ),
            IconButton(
              // user profile icon
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Action for the search button
              },
            ),
            ],
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 129, 211, 53),
              
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 22, 209, 209),
                  blurRadius: 10,// Shadow position
                ),
              ],
            ),
            padding: EdgeInsets.all(25),
            // child: Text("Hello World", 
            //   style: TextStyle(
            //     fontSize: 24,
            //     color: const Color.fromARGB(255, 0, 0, 0),
            //     fontWeight: FontWeight.bold
            //   ),
            //   textAlign: TextAlign.center,          
            // ),
            child: Icon(
              Icons.flutter_dash,
              size: 100,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
        
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}