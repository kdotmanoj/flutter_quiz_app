import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalPoints = 0;
  Map<String, bool> unlockedLevels = {
    'Easy': true,
    'Medium': false,
    'Hard': false,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final score = ModalRoute.of(context)?.settings.arguments as int?;
      if (score != null) {
        setState(() {
          totalPoints += score;
          _unlockLevels();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score: $totalPoints', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Select Difficulty:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            _buildDifficultyButton('Easy', isLocked: !unlockedLevels['Easy']!),
            _buildDifficultyButton('Medium', isLocked: !unlockedLevels['Medium']!),
            _buildDifficultyButton('Hard', isLocked: !unlockedLevels['Hard']!),
          ],
        ),
      ),
    );
  }

  void _startQuiz(String difficulty) async {
    final score = await Navigator.pushNamed(
      context,
      '/quiz',
      arguments: difficulty,
    );

    print('Returned score: $score');

    if (score != null) {
      setState(() {
        totalPoints += score as int; // Update the total score
        _unlockLevels();
      });
    }
  }

  void _unlockLevels() {
    if (totalPoints >= 800) {
      unlockedLevels['Medium'] = true;
    }
    if (totalPoints >= 2000) {
      unlockedLevels['Hard'] = true;
    }
  }

  Widget _buildDifficultyButton(String difficulty, {bool isLocked = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: isLocked ? null : () => _startQuiz(difficulty),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(difficulty),
            if (isLocked)
              Icon(Icons.lock, color: Colors.red)
            else
              Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
