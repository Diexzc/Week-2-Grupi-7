import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';

/// Pika hyrëse e aplikacionit Registration Form.
void main() {
  runApp(const RegistrationApp());
}

/// Widget-i rrënjë i aplikacionit.
///
/// Konfiguron temën e errët me ngjyra vjollcë dhe navigimin.
class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF7C4DFF),
        scaffoldBackgroundColor: const Color(0xFF0A0A1A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C4DFF),
          secondary: Color(0xFF448AFF),
          surface: Color(0xFF1A1035),
          error: Color(0xFFFF5252),
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}
