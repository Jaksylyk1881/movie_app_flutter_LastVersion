import 'package:flutter/material.dart';
import 'package:movie_app/presentation/screens/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        // This is the theme of your application.

      ),
      home: const FirstPage(),
    );
  }
}
