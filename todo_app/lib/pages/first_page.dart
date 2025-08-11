import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1st Page'),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        child: Column(
          children: [
            // common to place a DrawerHeader at the top of the drawer
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 48,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 166, 33, 243),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),

            // home page list tile
            ListTile(
              leading: Icon(Icons.home),
              title: Text('H O M E'),
              onTap: () {
                // pop drawer first
                Navigator.pop(context);

                //  got to home page
                Navigator.pushNamed(context, '/homepage');
              },
            ),

            // settings page list tile
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('S E T T I N G S'),
              onTap: () {
                // pop drawer first
                Navigator.pop(context);
                // go to settings page
                Navigator.pushNamed(context, '/settingspage');
              },
            ),
          ],
        )
      ),
    );
  }
}