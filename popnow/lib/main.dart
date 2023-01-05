import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const popnow());
}

class popnow extends StatelessWidget {
  const popnow({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes:
      {
        '/': (context) => const homepage(),
        // '/second': (context) => const SecondRoute(),
      },
    );
  }
}
