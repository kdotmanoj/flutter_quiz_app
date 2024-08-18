import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String difficulty;
  QuizScreen({required this.difficulty});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Question>> _questionsFuture;
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  String? _selectedExplanation;
  bool _showExplanation = false;

  @override
  void initState() {
    super.initState();
    _questionsFuture = ApiService.getQuestions(widget.difficulty);
  }

  void _handleOptionTap(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _showExplanation = false; // Reset explanation visibility
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) return; // No answer selected

    final currentQuestion = _questions[_currentIndex];
    setState(() {
      if (_selectedAnswer == currentQuestion.correctAnswer) {
        _score += 100; // 100 points for a correct answer
      }
      _selectedExplanation = currentQuestion.explanation;
      _showExplanation = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
        _selectedExplanation = null;
        _showExplanation = false;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: _score),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz (${widget.difficulty})'),
      ),
      body: FutureBuilder<List<Question>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No questions available.'));
          } else {
            _questions = snapshot.data!;
            Question currentQuestion = _questions[_currentIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentQuestion.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.0),
                  ...currentQuestion.options.map((option) {
                    bool isSelected = _selectedAnswer == option;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _handleOptionTap(option);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.blue : Colors.grey,
                        ),
                        child: Text(option),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                    ),
                    child: Text('Submit Answer'),
                  ),
                  if (_showExplanation)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Explanation:', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: 8.0),
                          Text(_selectedExplanation ?? 'No explanation available.'),
                        ],
                      ),
                    ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                    ),
                    child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
