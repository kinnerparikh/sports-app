import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sports_app/pages/trending_page/InstaBody.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          primaryIconTheme: IconThemeData(color: Colors.black),
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))),
      home: InstaBody(),
    );
  }
}
