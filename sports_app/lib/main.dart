import 'package:flutter/material.dart';
import 'package:sports_app/pages/esports.dart';
import 'package:sports_app/pages/favorites.dart';
import 'package:sports_app/pages/sports.dart';
import 'package:sports_app/pages/trending.dart';
import 'package:sports_app/pages/notifications.dart';

import 'objects/league.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
//
      ),
      home: MyHomePage(title: 'Sports Stop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Widget> _myPages = <Widget>[
    Trending(),
    Favorites(),
    Esports(),
    Sports()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
      body: _myPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.redAccent,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_fire_department,
            ),
            title: Text('Trending'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            title: Text(
              'Favorites',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_rounded),
            title: Text('Esports'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            title: Text('Sports'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
