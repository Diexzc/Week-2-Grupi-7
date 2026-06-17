import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

/// Pika hyrëse e aplikacionit Quiz.
void main() {
  runApp(const QuizApp());
}

/// Widget-i rrënjë i aplikacionit.
///
/// Konfiguron temën me ngjyra të errëta dhe navigimin.
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF0F0C29),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00C853),
          surface: Color(0xFF1A1A2E),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}
