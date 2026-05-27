import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Quiz Flutter',
    // ColorScheme.fromSeed — moderno, sem MaterialColor deprecated
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const WelcomeScreen(),
  );
}