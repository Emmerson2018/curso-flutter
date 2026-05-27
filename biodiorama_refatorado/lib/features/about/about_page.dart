// ============================================================
// Tela Sobre — informações do projeto e créditos IFAM
// ============================================================

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Logo
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.corVerde.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.forest, size: 64, color: AppTheme.corVerde),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'BioDiorama IA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Versão 1.0.0',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
          const SizedBox(height: 24),

          // Descrição
          const _Secao(
            titulo: 'Sobre o projeto',
            conteudo:
                'BioDiorama IA é um aplicativo educacional desenvolvido no IFAM '
                '(Instituto Federal do Amazonas) para o curso de Flutter e Dart. '
                'O app analisa dioramas biológicos amazônicos com Inteligência '
                'Artificial e apresenta os resultados de forma acessível a todos: '
                'estudantes típicos, surdos e cegos.',
          ),

          const _Secao(
            titulo: 'Acessibilidade',
            conteudo:
                'O app oferece suporte a Libras (Língua Brasileira de Sinais), '
                'audiodescrição via Text-to-Speech em português do Brasil, '
                'alto contraste visual e escala de fonte ajustável de 80% a 200%.',
          ),

          const _Secao(
            titulo: 'Tecnologias',
            conteudo:
                'Flutter 3.x · Dart 3.x · Google Gemini Vision (IA) · '
                'flutter_tts · video_player · go_router · Provider · '
                'SharedPreferences · image_picker',
          ),

          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),

          // Recursos de acessibilidade
          const _ItemInfo(
              icone: Icons.sign_language,
              cor: AppTheme.corLibras,
              texto: 'Suporte a Libras com vídeos de intérprete'),
          const _ItemInfo(
              icone: Icons.volume_up,
              cor: AppTheme.corVerde,
              texto: 'Audiodescrição em pt-BR (TTS)'),
          _ItemInfo(
              icone: Icons.contrast,
              cor: Colors.orange.shade800,
              texto: 'Tema de alto contraste'),
          _ItemInfo(
              icone: Icons.text_fields,
              cor: Colors.blue.shade700,
              texto: 'Escala de fonte 80% a 200%'),
          _ItemInfo(
              icone: Icons.accessibility_new,
              cor: Colors.purple.shade700,
              texto: 'Semantics completo para TalkBack / VoiceOver'),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao({required this.titulo, required this.conteudo});
  final String titulo;
  final String conteudo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(conteudo, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ItemInfo extends StatelessWidget {
  const _ItemInfo({required this.icone, required this.cor, required this.texto});
  final IconData icone;
  final Color cor;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icone, color: cor, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }
}
