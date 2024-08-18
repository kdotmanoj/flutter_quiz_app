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
        Navigator.pushReplacement(
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
                children: [
                  // Question Counter
                  Text(
                    'Question ${_currentIndex + 1}/${_questions.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16.0),

                  // Progress Bar
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16.0),

                  // Question Text
                  Text(
                    currentQuestion.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.0),

                  // Options
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...currentQuestion.options.map((option) {
                          bool isSelected = _selectedAnswer == option;
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_showExplanation) {
                                  _handleOptionTap(option);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? Colors.blue : Colors.grey,
                              ),
                              child: Text(option),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Spacer to push buttons to the bottom
                  Spacer(),

                  // Explanation and Feedback
                  if (_showExplanation)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedAnswer == currentQuestion.correctAnswer ? 'Correct!' : 'Incorrect!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: _selectedAnswer == currentQuestion.correctAnswer ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('Explanation:', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: 8.0),
                          Text(_selectedExplanation ?? 'No explanation available.'),
                        ],
                      ),
                    ),

                  // Submit and Next Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!_showExplanation)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submitAnswer,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text('Submit Answer'),
                          ),
                        ),
                      if (_showExplanation)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                          ),
                        ),
                    ],
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
