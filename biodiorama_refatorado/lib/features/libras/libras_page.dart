// ============================================================
// AULA 11 — Libras: Player de vídeo com fallback de texto
// AcessibilidadeProvider controla exibição automática.
// ============================================================

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/models/diorama_analysis.dart';
import '../../shared/widgets/acessibilidade_bar.dart';
import '../../shared/widgets/especie_card.dart';

class LibrasPage extends StatefulWidget {
  const LibrasPage({super.key, required this.analise});

  final DioramaAnalysis analise;

  @override
  State<LibrasPage> createState() => _LibrasPageState();
}

class _LibrasPageState extends State<LibrasPage> {
  VideoPlayerController? _controller;
  bool _carregando = true;
  bool _reproduzindo = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    if (widget.analise.temLibras) {
      _iniciarPlayer();
    } else {
      setState(() => _carregando = false);
    }
  }

  Future<void> _iniciarPlayer() async {
    try {
      final url = widget.analise.urlVideoLibras!;
      final controller = url.startsWith('http')
          ? VideoPlayerController.networkUrl(Uri.parse(url))
          : VideoPlayerController.asset(url);

      await controller.initialize();
      setState(() {
        _controller = controller;
        _carregando = false;
      });
      // Inicia automaticamente para usuários surdos
      await controller.play();
      setState(() => _reproduzindo = true);
    } catch (_) {
      setState(() {
        _carregando = false;
        _erro = 'Vídeo de Libras indisponível no momento.';
      });
    }
  }

  void _togglePlay() {
    if (_controller == null) return;
    if (_reproduzindo) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    setState(() => _reproduzindo = !_reproduzindo);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.corLibras,
        title: const Row(
          children: [
            Icon(Icons.sign_language, color: Colors.white),
            SizedBox(width: 8),
            Text('Análise em Libras', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: Column(
        children: [
          // Player de vídeo ou fallback — Aula 11
          _SecaoPlayer(
            carregando: _carregando,
            erro: _erro,
            controller: _controller,
            reproduzindo: _reproduzindo,
            onToggle: _togglePlay,
            legendaTexto: widget.analise.audioDescricao,
          ),
          const Divider(height: 1),

          // Lista de espécies com roteiro em Libras — Aula 11
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Espécies em Libras',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.corLibras,
                      ),
                ),
                const SizedBox(height: 8),
                ...widget.analise.especiesDetectadas.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: EspecieCard(especie: e),
                  ),
                ),
                const SizedBox(height: 16),

                // Roteiro para intérprete (texto simplificado)
                Text(
                  'Roteiro do intérprete',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.corLibras,
                      ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.corLibras.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppTheme.corLibras.withValues(alpha: 0.2)),
                  ),
                  // Gera roteiro concatenando todas as espécies — Aula 3 (map+join)
                  child: Text(
                    widget.analise.especiesDetectadas
                        .map((e) => e.gerarDescricaoLibras())
                        .join('\n\n'),
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Seção do player de vídeo com fallback — Aula 11
// ----------------------------------------------------------
class _SecaoPlayer extends StatelessWidget {
  const _SecaoPlayer({
    required this.carregando,
    required this.erro,
    required this.controller,
    required this.reproduzindo,
    required this.onToggle,
    required this.legendaTexto,
  });

  final bool carregando;
  final String? erro;
  final VideoPlayerController? controller;
  final bool reproduzindo;
  final VoidCallback onToggle;
  final String legendaTexto;

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (erro != null || controller == null) {
      // Fallback: mostra texto do roteiro quando não há vídeo
      return Container(
        padding: const EdgeInsets.all(16),
        color: AppTheme.corLibras.withValues(alpha: 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline,
                    color: AppTheme.corLibras, size: 18),
                const SizedBox(width: 6),
                Text(
                  erro ?? 'Vídeo não disponível',
                  style: const TextStyle(
                      color: AppTheme.corLibras, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Exibe o texto como alternativa acessível
            Semantics(
              label: 'Descrição em texto da análise: $legendaTexto',
              child: Text(legendaTexto,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      );
    }

    return Semantics(
      label: 'Vídeo em Libras. ${reproduzindo ? "Reproduzindo." : "Pausado."}',
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: controller!.value.aspectRatio,
            child: VideoPlayer(controller!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    label:
                        reproduzindo ? 'Pausar vídeo' : 'Reproduzir vídeo',
                    button: true,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.corLibras),
                      onPressed: onToggle,
                      icon: Icon(
                          reproduzindo ? Icons.pause : Icons.play_arrow),
                      label: Text(reproduzindo ? 'Pausar' : 'Reproduzir'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Legenda em texto sempre visível — Aula 11
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              legendaTexto,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
