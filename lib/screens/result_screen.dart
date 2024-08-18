import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', // Navigate to HomeScreen
                      (Route<dynamic> route) => false,
                  arguments: score, // Pass the score
                );
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
