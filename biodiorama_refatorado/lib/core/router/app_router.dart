// ============================================================
// AULA 7 — Navegação com go_router
// Todas as rotas do app declaradas em um único lugar.
// Substitui os Navigator.push() espalhados pelo código original.
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_page.dart';
import '../../features/image_analysis/image_analysis_page.dart';
import '../../features/prompt_analysis/prompt_analysis_page.dart';
import '../../features/result/result_page.dart';
import '../../features/libras/libras_page.dart';
import '../../features/embriologia/embriologia_page.dart';
import '../../features/history/history_page.dart';
import '../../features/accessibility_settings/accessibility_settings_page.dart';
import '../../features/about/about_page.dart';
import '../../domain/models/diorama_analysis.dart';

// Extra: usamos um objeto compartilhado para passar DioramaAnalysis
// entre rotas sem serializar/deserializar (padrão go_router extra).
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/analise-texto',
      builder: (context, state) => const PromptAnalysisPage(),
    ),
    GoRoute(
      path: '/analise-imagem',
      builder: (context, state) => const ImageAnalysisPage(),
    ),
    GoRoute(
      path: '/resultado',
      builder: (context, state) {
        // DioramaAnalysis é passado via extra (objeto em memória)
        final analise = state.extra as DioramaAnalysis;
        return ResultPage(analise: analise);
      },
    ),
    GoRoute(
      path: '/libras',
      builder: (context, state) {
        final analise = state.extra as DioramaAnalysis;
        return LibrasPage(analise: analise);
      },
    ),
    GoRoute(
      path: '/embriologia',
      builder: (context, state) => const EmbriologiaPage(),
    ),
    GoRoute(
      path: '/historico',
      builder: (context, state) => const HistoryPage(),
    ),
    GoRoute(
      path: '/acessibilidade',
      builder: (context, state) => const AccessibilitySettingsPage(),
    ),
    GoRoute(
      path: '/sobre',
      builder: (context, state) => const AboutPage(),
    ),
  ],
  // Rota de erro para URL inválida
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Página não encontrada')),
    body: Center(child: Text('Rota "${state.uri}" não existe.')),
  ),
);
