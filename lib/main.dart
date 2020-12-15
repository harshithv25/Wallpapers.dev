import 'package:flutter/material.dart';
import 'package:wallpapersdev/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpapers.dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(19, 28, 33, 1),
        primaryColor: Colors.black,
      ),
      home: Home(),
    );
  }
}
