// ============================================================
// AULA 12 — Módulo Educacional: Desenvolvimento Embrionário
// PageView com 8 estágios + TTS automático + Libras condicional.
// ============================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/services/tts_service.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/estagio_embrionario.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class EmbriologiaPage extends StatefulWidget {
  const EmbriologiaPage({super.key});

  @override
  State<EmbriologiaPage> createState() => _EmbriologiaPageState();
}

class _EmbriologiaPageState extends State<EmbriologiaPage> {
  final PageController _pageCtrl = PageController();
  int _estagioAtual = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    TtsService.instancia.parar();
    super.dispose();
  }

  void _irPara(int index) {
    if (index < 0 || index >= estagiosHumanos.length) return;
    _pageCtrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _aoMudarPagina(int index) {
    setState(() => _estagioAtual = index);
    // Narra automaticamente se audiodescrição ativa — Aula 10
    final acess = context.read<AcessibilidadeProvider>();
    if (acess.audioDescricaoAtivado) {
      TtsService.instancia.narrarEstagio(estagiosHumanos[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final acess = context.watch<AcessibilidadeProvider>();
    final total = estagiosHumanos.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Estágio ${_estagioAtual + 1} de $total'),
        actions: [
          // Botão de narrar TTS — Aula 10
          Semantics(
            label: 'Narrar descrição deste estágio',
            button: true,
            child: IconButton(
              icon: const Icon(Icons.volume_up),
              tooltip: 'Narrar',
              onPressed: () => TtsService.instancia
                  .narrarEstagio(estagiosHumanos[_estagioAtual]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: Column(
        children: [
          // Linha do tempo visual — Aula 12
          _LinhaDoTempo(
            total: total,
            atual: _estagioAtual,
            onTap: _irPara,
          ),
          const Divider(height: 1),

          // Conteúdo paginado — Aula 12 (PageView)
          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              onPageChanged: _aoMudarPagina,
              itemCount: total,
              itemBuilder: (context, i) => _CartaoEstagio(
                estagio: estagiosHumanos[i],
                librasAtivo: acess.librasAtivado,
              ),
            ),
          ),

          // Controles de navegação
          _ControlesNavegacao(
            podeVoltar: _estagioAtual > 0,
            podeAvancar: _estagioAtual < total - 1,
            onVoltar: () => _irPara(_estagioAtual - 1),
            onAvancar: () => _irPara(_estagioAtual + 1),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Linha do tempo de pontos clicáveis
// ----------------------------------------------------------
class _LinhaDoTempo extends StatelessWidget {
  const _LinhaDoTempo({
    required this.total,
    required this.atual,
    required this.onTap,
  });

  final int total;
  final int atual;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Linha do tempo: estágio ${atual + 1} de $total',
      child: SizedBox(
        height: 48,
        child: Row(
          children: List.generate(total, (i) {
            final ativo = i == atual;
            final passado = i < atual;
            return Expanded(
              child: Semantics(
                label: 'Estágio ${i + 1}: ${estagiosHumanos[i].nome}.'
                    '${ativo ? " Atual." : ""}',
                button: true,
                child: GestureDetector(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: ativo ? 20 : 10,
                        height: ativo ? 20 : 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ativo
                              ? AppTheme.corVerde
                              : passado
                                  ? AppTheme.corVerdeClaro
                                  : Colors.grey.shade300,
                        ),
                      ),
                      if (ativo)
                        Text(
                          '${i + 1}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.corVerde,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Card de cada estágio embrionário
// ----------------------------------------------------------
class _CartaoEstagio extends StatelessWidget {
  const _CartaoEstagio({
    required this.estagio,
    required this.librasAtivo,
  });

  final EstagioEmbrionario estagio;
  final bool librasAtivo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagem do estágio
          Semantics(
            label: 'Imagem: ${estagio.gerarTextoLeitorDeTela()}',
            image: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 200,
                color: AppTheme.corVerde.withValues(alpha: 0.08),
                child: Image.asset(
                  estagio.urlImagem,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.science_outlined,
                            size: 64,
                            color: AppTheme.corVerde.withValues(alpha: 0.4)),
                        const SizedBox(height: 8),
                        Text(
                          estagio.nome,
                          style: TextStyle(
                              color: AppTheme.corVerde.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Número e nome
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.corVerde,
                ),
                child: Text(
                  '${estagio.numero}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      estagio.nome,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Dia ${estagio.diasAposFerti} após a fertilização',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Descrição
          Semantics(
            label: estagio.gerarAudioDescricao(),
            child: Text(
              estagio.descricao,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

          // Player de Libras (se ativo e disponível) — Aula 11
          if (librasAtivo && estagio.temLibras) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.corLibras.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.corLibras.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.sign_language,
                          color: AppTheme.corLibras, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Conteúdo em Libras disponível',
                        style: TextStyle(
                            color: AppTheme.corLibras,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    estagio.gerarDescricaoLibras(),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],

          // Dica: deslize para navegar
          const SizedBox(height: 20),
          ExcludeSemantics(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swipe, color: Colors.grey.shade400, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Deslize para navegar entre os estágios',
                  style: TextStyle(
                      color: Colors.grey.shade400, fontSize: 12),
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
// Controles de navegação entre estágios
// ----------------------------------------------------------
class _ControlesNavegacao extends StatelessWidget {
  const _ControlesNavegacao({
    required this.podeVoltar,
    required this.podeAvancar,
    required this.onVoltar,
    required this.onAvancar,
  });

  final bool podeVoltar;
  final bool podeAvancar;
  final VoidCallback onVoltar;
  final VoidCallback onAvancar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                label: 'Ir para estágio anterior',
                button: true,
                child: OutlinedButton.icon(
                  onPressed: podeVoltar ? onVoltar : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Anterior'),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                label: 'Ir para próximo estágio',
                button: true,
                child: FilledButton.icon(
                  onPressed: podeAvancar ? onAvancar : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Próximo'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
