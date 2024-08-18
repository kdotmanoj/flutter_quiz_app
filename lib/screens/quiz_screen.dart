<<<<<<< HEAD
// quiz_screen.dart
=======
>>>>>>> origin/master
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
<<<<<<< HEAD
  bool _answerSubmitted = false;
  bool _isCorrect = false;
=======
>>>>>>> origin/master

  @override
  void initState() {
    super.initState();
    _questionsFuture = ApiService.getQuestions(widget.difficulty);
  }

<<<<<<< HEAD
  void _handleOptionTap(String answer, String correctAnswer, String explanation) {
    if (_answerSubmitted) return;

    setState(() {
      _selectedAnswer = answer;
      _isCorrect = answer == correctAnswer;
      _selectedExplanation = explanation;
    });
  }


=======
  void _handleOptionTap(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _showExplanation = false; // Reset explanation visibility
    });
  }

>>>>>>> origin/master
  void _submitAnswer() {
    if (_selectedAnswer == null) return; // No answer selected

    final currentQuestion = _questions[_currentIndex];
    setState(() {
<<<<<<< HEAD
      _showExplanation = true;
      _answerSubmitted = true;
      _selectedExplanation = currentQuestion.explanation;
      _isCorrect = _selectedAnswer == currentQuestion.correctAnswer;
      if (_isCorrect) {
        _score += 100; // 100 points for a correct answer
      }
=======
      if (_selectedAnswer == currentQuestion.correctAnswer) {
        _score += 100; // 100 points for a correct answer
      }
      _selectedExplanation = currentQuestion.explanation;
      _showExplanation = true;
>>>>>>> origin/master
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
        _selectedExplanation = null;
        _showExplanation = false;
<<<<<<< HEAD
        _answerSubmitted = false; // Reset answer submission state
      } else {
        Navigator.pushReplacement(
=======
      } else {
        Navigator.push(
>>>>>>> origin/master
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
<<<<<<< HEAD
                  // Progress Bar
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16.0),
=======
>>>>>>> origin/master
                  Text(
                    currentQuestion.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.0),
<<<<<<< HEAD
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...currentQuestion.options.map((option) {
                            bool isSelected = _selectedAnswer == option;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_answerSubmitted) {
                                    _handleOptionTap(
                                      option,
                                      currentQuestion.correctAnswer,
                                      currentQuestion.explanation,
                                    );
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
                  ),
                  if (!_answerSubmitted)
                    ElevatedButton(
                      onPressed: _submitAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Submit Answer'),
                    ),
=======
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
>>>>>>> origin/master
                  if (_showExplanation)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
<<<<<<< HEAD
                          Text(
                            _isCorrect ? 'Correct!' : 'Incorrect!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: _isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: 8.0),
=======
>>>>>>> origin/master
                          Text('Explanation:', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: 8.0),
                          Text(_selectedExplanation ?? 'No explanation available.'),
                        ],
                      ),
                    ),
                  SizedBox(height: 16.0),
<<<<<<< HEAD
                  if (_answerSubmitted || _showExplanation)
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                    ),
=======
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                    ),
                    child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                  ),
>>>>>>> origin/master
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
