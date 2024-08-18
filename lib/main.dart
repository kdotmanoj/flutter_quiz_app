import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
<<<<<<< HEAD
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
=======
>>>>>>> origin/master

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/quiz': (context) {
          final difficulty = ModalRoute.of(context)!.settings.arguments as String;
          return QuizScreen(difficulty: difficulty);
        },
        '/result': (context) {
          final score = ModalRoute.of(context)!.settings.arguments as int;
          return ResultScreen(score: score);
        },
      },
=======
      home: HomeScreen(),
>>>>>>> origin/master
    );
  }
}
