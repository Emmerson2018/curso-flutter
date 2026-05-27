// ============================================================
// AULA 6 — Layout Responsivo e ThemeData Acessível
// Dois temas: claro (padrão) e altoContraste (baixa visão).
// Aplicado dinamicamente via AcessibilidadeProvider.
// ============================================================

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Cores do projeto BioDiorama — alinhadas com os slides IFAM
  static const _verde = Color(0xFF1B6B35);
  static const _verdeClaro = Color(0xFF2E8B57);
  static const _roxoLibras = Color(0xFF4527A0);

  // ----------------------------------------------------------
  // Tema Claro (padrão)
  // ----------------------------------------------------------
  static ThemeData get claro => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _verde,
          brightness: Brightness.light,
        ),
        // Tamanhos de fonte mínimos para acessibilidade (WCAG AA)
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, letterSpacing: 0.3),
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge:
              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          titleMedium:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        // Botões com área de toque mínima de 52dp (diretriz Android/iOS)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _verde,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

  // ----------------------------------------------------------
  // Tema Alto Contraste (baixa visão)
  // ----------------------------------------------------------
  static ThemeData get altoContraste => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.highContrastDark(),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontSize: 18),
          titleLarge:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      );

  // Cor do botão de Libras (roxa — identidade visual do módulo)
  static const corLibras = _roxoLibras;
  static const corVerde = _verde;
  static const corVerdeClaro = _verdeClaro;
}
