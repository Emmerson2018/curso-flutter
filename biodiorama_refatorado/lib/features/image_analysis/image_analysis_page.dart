// ============================================================
// AULA 8 — Câmera, Galeria e Imagens de Dioramas
// AULA 4 — Stream<String> de progresso com StreamBuilder
// AULA 9 — Integração com IAService
// ============================================================

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/services/ia_service.dart';
import '../../core/services/tts_service.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/diorama_analysis.dart';
import '../../domain/models/resultado_api.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class ImageAnalysisPage extends StatefulWidget {
  const ImageAnalysisPage({super.key});

  @override
  State<ImageAnalysisPage> createState() => _ImageAnalysisPageState();
}

class _ImageAnalysisPageState extends State<ImageAnalysisPage> {
  final ImagePicker _picker = ImagePicker();
  final IAService _iaService = IAService();

  File? _imagem;

  // Estado de análise: usa ResultadoAPI<T> — Aula 3
  ResultadoAPI<DioramaAnalysis> _estado = ResultadoAPI.carregando()
      ..toString(); // trick: começa "vazio"
  bool _analisando = false;
  String _mensagemProgresso = '';

  @override
  void initState() {
    super.initState();
    _estado = ResultadoAPI<DioramaAnalysis>.sucesso(
      // estado inicial: sem dados, sem erro
      DioramaAnalysis(
        idAnalise: '',
        dataAnalise: DateTime.now(),
        especiesDetectadas: [],
        interacoesEcologicas: '',
        confiancaIA: 0,
      ),
    );
  }

  // ----------------------------------------------------------
  // Captura de imagem — Aula 8
  // ----------------------------------------------------------
  Future<void> _capturar(ImageSource fonte) async {
    final XFile? arquivo = await _picker.pickImage(
      source: fonte,
      maxWidth: 1920,
      imageQuality: 85,
    );
    if (arquivo == null) return;
    setState(() => _imagem = File(arquivo.path));
  }

  // ----------------------------------------------------------
  // Análise com progresso via Stream — Aula 4
  // ----------------------------------------------------------
  Future<void> _analisar() async {
    final imagem = _imagem;
    if (imagem == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escolha ou fotografe um diorama primeiro.'),
        ),
      );
      return;
    }

    setState(() => _analisando = true);

    // Consome o Stream de progresso (async* / yield — Aula 4)
    await for (final mensagem in _iaService.analisarComProgresso(imagem)) {
      if (!mounted) return;
      setState(() => _mensagemProgresso = mensagem);

      // TTS lê cada mensagem de progresso se audiodescrição ativa
      final acess = context.read<AcessibilidadeProvider>();
      if (acess.audioDescricaoAtivado) {
        await TtsService.instancia.falar(mensagem);
      }
    }

    // Chama a análise real após o stream de progresso
    final resultado = await _iaService.analisarImagem(imagem);

    if (!mounted) return;
    setState(() {
      _estado = resultado;
      _analisando = false;
    });

    // Navega para resultado se sucesso
    if (resultado.temDados) {
      final acess = context.read<AcessibilidadeProvider>();
      if (acess.audioDescricaoAtivado) {
        await TtsService.instancia.narrarAnalise(resultado.dados!);
      }
      if (mounted) {
        context.push('/resultado', extra: resultado.dados!);
      }
    } else if (resultado.temErro) {
      final acess = context.read<AcessibilidadeProvider>();
      if (acess.audioDescricaoAtivado) {
        await TtsService.instancia.narrarErro(resultado.mensagemErro!);
      }
    }
  }

  // ----------------------------------------------------------
  // UI
  // ----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisar por imagem')),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Botões de fonte da imagem — Aula 8
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: 'Tirar foto com a câmera',
                    hint: 'Toque duas vezes para abrir a câmera',
                    button: true,
                    child: OutlinedButton.icon(
                      onPressed:
                          _analisando ? null : () => _capturar(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Câmera'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Semantics(
                    label: 'Importar imagem da galeria',
                    hint: 'Toque duas vezes para abrir a galeria',
                    button: true,
                    child: OutlinedButton.icon(
                      onPressed:
                          _analisando ? null : () => _capturar(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Galeria'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Preview da imagem — Aula 8 (slide 50)
            Semantics(
              label: _imagem == null
                  ? 'Nenhuma imagem selecionada. Use os botões acima.'
                  : 'Imagem do diorama selecionada. Pronta para análise.',
              image: _imagem != null,
              child: Container(
                height: 260,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.4),
                ),
                child: _imagem == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 56,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nenhuma imagem selecionada',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Image.file(
                            _imagem!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Barra de progresso com mensagens — Aula 4 (Stream)
            if (_analisando) ...[
              LinearProgressIndicator(
                backgroundColor:
                    AppTheme.corVerde.withValues(alpha: 0.2),
                color: AppTheme.corVerde,
              ),
              const SizedBox(height: 8),
              Semantics(
                liveRegion: true, // anuncia mudanças ao TalkBack
                child: Text(
                  _mensagemProgresso,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppTheme.corVerde,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Mensagem de erro (se houver) — ResultadoAPI<T> — Aula 3
            if (_estado.temErro && !_analisando)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _estado.mensagemErro!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            // Botão principal — Aula 5
            Semantics(
              label: _analisando
                  ? 'Analisando imagem, aguarde'
                  : 'Analisar diorama com Inteligência Artificial',
              hint: _analisando ? null : 'Toque duas vezes para analisar',
              button: true,
              child: FilledButton.icon(
                onPressed: _analisando ? null : _analisar,
                icon: _analisando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.psychology_alt),
                label: Text(_analisando
                    ? 'Processando...'
                    : 'Analisar com IA'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
