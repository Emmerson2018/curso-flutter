// ============================================================
// AULA 7 — MaterialApp.router + ThemeData dinâmico
// O tema muda em tempo real conforme AcessibilidadeProvider.
// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/providers/acessibilidade_provider.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';

class BioDioramaApp extends StatelessWidget {
  const BioDioramaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() reconstrói o app quando tema/fonte mudam
    final acess = context.watch<AcessibilidadeProvider>();

    return MaterialApp.router(
      title: 'BioDiorama IA',
      debugShowCheckedModeBanner: false,

      // Troca de tema em tempo real — Aula 7
      theme: acess.altoContrasteAtivado
          ? AppTheme.altoContraste
          : AppTheme.claro,

      // Escala de fonte global — aplica em TODOS os textos do app
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(acess.escalaFonte),
        ),
        child: child!,
      ),

      routerConfig: appRouter,
    );
  }
}
