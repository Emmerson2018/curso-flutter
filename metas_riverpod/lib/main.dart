import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/goals_screen.dart';

void main() {
  runApp(
    // ProviderScope: OBRIGATÓRIO — cria o container de todos os providers
    // Sem ele, qualquer ref.watch/read lança UnimplementedError
    const ProviderScope(
      child: MetasApp(),
    ),
  );
}

class MetasApp extends StatelessWidget {
  const MetasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerenciador de Metas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7), // azul
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const GoalsScreen(),
    );
  }
}