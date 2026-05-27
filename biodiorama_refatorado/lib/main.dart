// ============================================================
// AULA 7 — Configuração dos Providers no ponto de entrada
// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'core/providers/acessibilidade_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega preferências de acessibilidade antes de renderizar
  final acessProvider = AcessibilidadeProvider();
  await acessProvider.carregarPreferencias();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: acessProvider),
      ],
      child: const BioDioramaApp(),
    ),
  );
}
