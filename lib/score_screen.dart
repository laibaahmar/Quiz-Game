import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'quiz_page.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ScoreScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    // Calculate percentage
    double percentage = (score / totalQuestions) * 100;

    // Determine success or failure
    bool isSuccess = percentage >= 50;

    return Scaffold(
      backgroundColor: Color(0xB2004643),
      appBar: AppBar(
        title: Text('Your Score', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Progress Indicator with percentage
            Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 1.0, // Full circle background
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDDC56B)),
                  ),
                ),
                // Foreground Circle (progress)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: percentage / 100, // Progress based on score percentage
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF8C660)),
                  ),
                ),
                // Center text for percentage
                Text(
                  "${percentage.toStringAsFixed(1)}%", // Show percentage with one decimal place
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Score text
            Text(
              'Your Score: $score / $totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            // Back to Home button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF8C660), // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                shadowColor: Colors.black.withOpacity(0.3), // Button shadow effect
                elevation: 5, // Shadow under the button
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Text('Back to Home', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            // Restart Quiz button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF8C660), // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                shadowColor: Colors.black.withOpacity(0.3), // Button shadow effect
                elevation: 5, // Shadow under the button
              ),
              onPressed: () {
                // Restart quiz with shuffled questions
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizHomeScreen(),
                  ),
                );
              },
              child: Text('Restart Quiz', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
