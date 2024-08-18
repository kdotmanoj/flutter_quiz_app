import 'package:flutter/material.dart';
import '../models/question.dart'; // Ensure you import your Question model
import '../api_service.dart'; // Ensure you import your ApiService

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Question? _question;
  bool _isHintVisible = false;
  bool _isAnswerSubmitted = false;
  bool _isCorrectAnswer = false;
  String _feedbackMessage = '';
  String _explanation = 'Explanation of the correct answer.';
  final _selectedOption = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _fetchQuestion(); // Fetch the question when the screen initializes
  }

  Future<void> _fetchQuestion() async {
    try {
      setState(() {
        _question = null; // Reset question while loading
        _isHintVisible = false;
        _isAnswerSubmitted = false;
        _feedbackMessage = '';
        _selectedOption.value = null; // Reset selected option
      });
      final question = await ApiService.fetchQuestion();
      setState(() {
        _question = question;
      });
    } catch (e) {
      print('Error fetching question: $e');
      // You might want to show an error message to the user here
    }
  }

  Future<void> _submitAnswer() async {
    if (_selectedOption.value != null) {
      try {
        final response = await ApiService.submitAnswer(_selectedOption.value!);
        setState(() {
          _isAnswerSubmitted = true;
          _isCorrectAnswer = response['correct'];
          _feedbackMessage = _isCorrectAnswer
              ? 'Congrats! You got it right!'
              : 'Oops! That\'s not correct.';
          _explanation = response['explanation'] ?? 'No explanation provided.';
        });
      } catch (e) {
        print('Error submitting answer: $e');
      }
    }
  }

  void _showHint() {
    setState(() {
      _isHintVisible = !_isHintVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while the question is being fetched
    if (_question == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _question?.question ?? 'Loading question...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...(_question?.options ?? []).map((option) => RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedOption.value,
              onChanged: (value) {
                _selectedOption.value = value;
              },
            )).toList(),
            SizedBox(height: 20),
            if (_isHintVisible && _question?.hint?.isNotEmpty == true)
              Text('Hint: ${_question!.hint}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _showHint,
                  child: Text(_isHintVisible ? 'Hide Hint' : 'Show Hint'),
                ),
                ElevatedButton(
                  onPressed: _submitAnswer,
                  child: Text('Submit'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_isAnswerSubmitted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _feedbackMessage,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _isCorrectAnswer ? Colors.green : Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explanation: $_explanation',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _fetchQuestion,
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: 0.5, // Example value - you need to calculate this based on the number of questions
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
