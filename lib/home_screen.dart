import 'package:assignment_mc_lab/quiz_page.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xB2004643),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // You can add a logo or some text here, e.g., an image of a light bulb or a quiz icon
              Icon(
                Icons.quiz_rounded,
                color: Colors.white,
                size: 100, // Large quiz icon
              ),
              SizedBox(height: 40), // Spacing between icon and button

              // Heading with a beautiful font style
              Text(
                'Are you ready for the challenge?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20), // Add some spacing before the button

              // The "Start Quiz" button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Quiz screen when the "Start Quiz" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizHomeScreen()),
                  );
                },
                child: Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}


