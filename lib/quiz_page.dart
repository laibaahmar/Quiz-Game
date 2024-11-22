import 'package:assignment_mc_lab/questions.dart';
import 'package:assignment_mc_lab/score_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class QuizHomeScreen extends StatefulWidget {
  @override
  _QuizHomeScreenState createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  List<Question> questions = [
    Question(
      questionText: 'What does the "RAM" in a computer stand for?',
      options: ['Random Access Memory', 'Read And Memory', 'Rapid Access Machine', 'Run After Memory'],
      correctAnswer: 'Random Access Memory',
    ),
    Question(
      questionText: 'Which of the following is a common type of digital storage used in smartphones and tablets?',
      options: ['Hard Drive', 'Flash Drive', 'SD Card', 'Blu-ray Disc'],
      correctAnswer: 'SD Card',
    ),
    Question(
      questionText: 'Which of the following is an email service provided by Google?',
      options: [' Yahoo Mail', 'Outlook', 'ProtonMail', 'Gmail'],
      correctAnswer: 'Gmail',
    ),
    Question(
      questionText: 'Which of the following platforms is used for streaming movies and TV shows?',
      options: ['Netflix', 'Spotify', 'WhatsApp', 'Discord'],
      correctAnswer: 'Netflix',
    ),
    Question(
      questionText: 'Which of the following is a popular programming language used for web development?',
      options: ['Python', 'Swift', 'Ruby', 'JavaScript'],
      correctAnswer: 'JavaScript',
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedAnswer;
  int timeLeft = 30; // 30 seconds timer
  Timer? _timer;

  // Function to move to the next question
  void nextQuestion(String? answer) {
    if (answer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        timeLeft = 30; // Reset the timer for the next question
      });
      startTimer(); // Start the timer for the next question
    } else {
      // End of quiz, go to score screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(score: score, totalQuestions: questions.length),
        ),
      );
      stopTimer(); // Stop the timer when quiz ends
    }
  }

  // Start the timer
  void startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    // Start a new timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        nextQuestion(selectedAnswer); // Move to next question when time is up
        stopTimer(); // Stop the timer
      }
    });
  }

  // Stop the timer
  void stopTimer() {
    _timer?.cancel(); // Cancel the timer
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer as soon as the quiz starts
  }

  @override
  void dispose() {
    stopTimer(); // Make sure to stop the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        foregroundColor: Color(0xB2004643),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quiz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                '${currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                // Question Card
                SizedBox(height: 50),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          currentQuestion.questionText,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Options List
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      String option = currentQuestion.options[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAnswer = option;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: selectedAnswer == option
                                ? Color(0xB2004643).withOpacity(0.5)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: Row(
                            children: [
                              Radio<String>(
                                activeColor: Color(0xB2004643),
                                value: option,
                                groupValue: selectedAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswer = value;
                                  });
                                },
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Next Button
                ElevatedButton(
                  onPressed: selectedAnswer != null
                      ? () => nextQuestion(selectedAnswer)
                      : null,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Color(0xFFF8C660), // Button color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    shadowColor: Colors.black.withOpacity(0.3), // Button shadow effect
                    elevation: 5, // Shadow under the button
                  ),
                ),
              ],
            ),
            // Timer with Circular Progress Bar
            Positioned(
              top: 0,  // Adjust to make the timer appear half over the question container
              left: (MediaQuery.sizeOf(context).width - 100) / 2,  // Center the timer horizontally
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circular progress (gray)
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 1.0, // Full circle
                      strokeWidth: 8,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  // Foreground circular progress (decreasing with time)
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: timeLeft / 30, // Proportional to remaining time
                      strokeWidth: 8,
                      color: Color(0xB2004643),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  // Timer text in the center
                  Text(
                    '$timeLeft',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xB2004643)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
