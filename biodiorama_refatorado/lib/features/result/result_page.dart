// ============================================================
// AULA 9 — Exibição do resultado da análise de IA
// AULA 10 — Audiodescrição automática via TtsService
// AULA 11 — Botão de Libras condicional ao AcessibilidadeProvider
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/services/history_service.dart';
import '../../core/services/tts_service.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/diorama_analysis.dart';
import '../../shared/widgets/acessibilidade_bar.dart';
import '../../shared/widgets/especie_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.analise});

  final DioramaAnalysis analise;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _salvo = false;
  bool _reproduzindoAudio = false;

  @override
  void initState() {
    super.initState();
    _salvarHistorico();
    // Narra automaticamente se audiodescrição ativa — Aula 10
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final acess = context.read<AcessibilidadeProvider>();
      if (acess.audioDescricaoAtivado) {
        TtsService.instancia.narrarAnalise(widget.analise);
      }
    });
  }

  Future<void> _salvarHistorico() async {
    await HistoryService().salvar(widget.analise);
    if (mounted) setState(() => _salvo = true);
  }

  @override
  void dispose() {
    TtsService.instancia.parar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final acess = context.watch<AcessibilidadeProvider>();
    final analise = widget.analise;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da análise'),
        actions: [
          // Ação de Libras sempre acessível na AppBar — Aula 11
          if (acess.librasAtivado || analise.temLibras)
            Semantics(
              label: 'Ver análise em Libras',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sign_language),
                tooltip: 'Ver em Libras',
                onPressed: () => context.push('/libras', extra: analise),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Banner salvo no histórico
          if (_salvo)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Análise salva no histórico'),
                ],
              ),
            ),

          // Confiança da IA
          _SecaoConfianca(confianca: analise.confiancaIA),
          const SizedBox(height: 16),

          // Espécies detectadas — EspecieCard com Semantics — Aula 6
          Semantics(
            header: true,
            child: Text(
              'Espécies identificadas (${analise.especiesDetectadas.length})',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          ...analise.especiesDetectadas
              .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: EspecieCard(especie: e),
                  )),

          const SizedBox(height: 16),

          // Interações ecológicas
          _CartaoInfo(
            titulo: 'Interações ecológicas',
            conteudo: analise.interacoesEcologicas,
            icone: Icons.hub_outlined,
          ),
          const SizedBox(height: 16),

          // Audiodescrição
          _CartaoInfo(
            titulo: 'Audiodescrição',
            conteudo: analise.audioDescricao,
            icone: Icons.record_voice_over,
          ),
          const SizedBox(height: 20),

          // Botões de acessibilidade — Aulas 10 e 11
          _BotoesAcessibilidade(
            analise: analise,
            reproduzindoAudio: _reproduzindoAudio,
            onPlayAudio: () async {
              setState(() => _reproduzindoAudio = true);
              await TtsService.instancia.narrarAnalise(analise);
              if (mounted) setState(() => _reproduzindoAudio = false);
            },
            onStopAudio: () {
              TtsService.instancia.parar();
              setState(() => _reproduzindoAudio = false);
            },
            onLibras: () => context.push('/libras', extra: analise),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Widgets internos
// ----------------------------------------------------------
class _SecaoConfianca extends StatelessWidget {
  const _SecaoConfianca({required this.confianca});
  final double confianca;

  @override
  Widget build(BuildContext context) {
    final pct = (confianca * 100).toStringAsFixed(1);
    return Semantics(
      label: 'Confiança da análise: $pct por cento',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.analytics_outlined,
                      color: AppTheme.corVerde),
                  const SizedBox(width: 8),
                  Text(
                    'Confiança da IA: $pct%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: confianca,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  color: confianca > 0.8
                      ? Colors.green
                      : confianca > 0.6
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartaoInfo extends StatelessWidget {
  const _CartaoInfo({
    required this.titulo,
    required this.conteudo,
    required this.icone,
  });
  final String titulo;
  final String conteudo;
  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: AppTheme.corVerde, size: 20),
                const SizedBox(width: 8),
                Text(titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Semantics(
              label: '$titulo: $conteudo',
              child: Text(conteudo,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotoesAcessibilidade extends StatelessWidget {
  const _BotoesAcessibilidade({
    required this.analise,
    required this.reproduzindoAudio,
    required this.onPlayAudio,
    required this.onStopAudio,
    required this.onLibras,
  });

  final DioramaAnalysis analise;
  final bool reproduzindoAudio;
  final VoidCallback onPlayAudio;
  final VoidCallback onStopAudio;
  final VoidCallback onLibras;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Play/pause audiodescrição — Aula 10
        Semantics(
          label: reproduzindoAudio
              ? 'Parar narração da audiodescrição'
              : 'Ouvir audiodescrição completa do diorama',
          button: true,
          child: FilledButton.icon(
            onPressed: reproduzindoAudio ? onStopAudio : onPlayAudio,
            icon: Icon(reproduzindoAudio ? Icons.stop : Icons.volume_up),
            label: Text(reproduzindoAudio
                ? 'Parar narração'
                : 'Ouvir audiodescrição'),
          ),
        ),
        const SizedBox(height: 10),

        // Botão Libras — Aula 11
        Semantics(
          label: 'Abrir conteúdo em Língua Brasileira de Sinais',
          hint: 'Toque duas vezes para ver o vídeo em Libras',
          button: true,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.corLibras,
            ),
            onPressed: onLibras,
            icon: const Icon(Icons.sign_language),
            label: const Text('Ver em Libras'),
          ),
        ),
      ],
    );
  }
}
