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

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late Future<List<Question>> _questionsFuture;
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  String? _selectedExplanation;
  bool _showExplanation = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _questionsFuture = ApiService.getQuestions(widget.difficulty);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      _animationController.forward(); // Start the animation
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
        _selectedExplanation = null;
        _showExplanation = false;
        _animationController.reset(); // Reset the animation
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Counter
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Question ${_currentIndex + 1}/${_questions.length}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                // Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / _questions.length,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 16.0),

                // Question Text
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    currentQuestion.text,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),

                // Display Image if exists
                if (currentQuestion.imageUrl != null)
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9, // Almost full width
                      constraints: BoxConstraints(
                        maxHeight: 200, // Adjust as needed
                      ),
                      child: Image.network(
                        currentQuestion.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),

                // Options
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns
                      crossAxisSpacing: 8.0, // Horizontal spacing
                      mainAxisSpacing: 8.0, // Vertical spacing
                      childAspectRatio: 2.0, // Aspect ratio for height and width
                    ),
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      final option = currentQuestion.options[index];
                      final isSelected = _selectedAnswer == option;
                      return ElevatedButton(
                        onPressed: () {
                          if (!_showExplanation) {
                            _handleOptionTap(option);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.blue : Colors.grey,
                        ),
                        child: Text(option),
                      );
                    },
                  ),
                ),

                // Explanation and Feedback
                if (_showExplanation)
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 8.0, // Horizontal spacing between elements
                        runSpacing: 4.0, // Vertical spacing between lines
                        children: [
                          Text(
                            _selectedAnswer == currentQuestion.correctAnswer ? 'Correct!' : 'Incorrect!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: _selectedAnswer == currentQuestion.correctAnswer ? Colors.green : Colors.red,
                            ),
                          ),
                          Text('Explanation:', style: Theme.of(context).textTheme.titleMedium),
                          Text(_selectedExplanation ?? 'No explanation available.'),
                        ],
                      ),
                    ),
                  ),

                // Submit and Next Buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
