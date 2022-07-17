import 'package:apod/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Picture of the Day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //dark theme

        brightness: Brightness.dark,
      ),
      home: const WelcomePage(),
    );
  }
}
