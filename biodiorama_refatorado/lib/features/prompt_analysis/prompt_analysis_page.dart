// ============================================================
// AULA 6 — Formulários e validação
// AULA 4 — Future + try/catch com ResultadoAPI<T>
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/providers/acessibilidade_provider.dart';
import '../../core/services/ia_service.dart';
import '../../core/services/tts_service.dart';
import '../../domain/models/resultado_api.dart';
import '../../domain/models/diorama_analysis.dart';
import '../../shared/widgets/acessibilidade_bar.dart';

class PromptAnalysisPage extends StatefulWidget {
  const PromptAnalysisPage({super.key});

  @override
  State<PromptAnalysisPage> createState() => _PromptAnalysisPageState();
}

class _PromptAnalysisPageState extends State<PromptAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();
  final _iaService = IAService();
  bool _carregando = false;
  ResultadoAPI<DioramaAnalysis>? _resultado;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _analisar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _carregando = true;
      _resultado = null;
    });

    final acess = context.read<AcessibilidadeProvider>();
    if (acess.audioDescricaoAtivado) {
      await TtsService.instancia.falar('Analisando diorama. Aguarde.');
    }

    final resultado = await _iaService.analisarTexto(_ctrl.text.trim());

    if (!mounted) return;
    setState(() {
      _carregando = false;
      _resultado = resultado;
    });

    if (resultado.temDados) {
      if (acess.audioDescricaoAtivado) {
        await TtsService.instancia.narrarAnalise(resultado.dados!);
      }
      if (mounted) context.push('/resultado', extra: resultado.dados!);
    } else if (resultado.temErro && acess.audioDescricaoAtivado) {
      await TtsService.instancia.narrarErro(resultado.mensagemErro!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analisar por texto')),
      bottomNavigationBar: const AcessibilidadeBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Descreva o diorama que você está observando.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),

              // Campo de texto com Semantics — Aula 6 / slide 40
              Semantics(
                label: 'Campo de descrição do diorama',
                hint: 'Digite pelo menos 10 caracteres',
                textField: true,
                child: TextFormField(
                  controller: _ctrl,
                  maxLines: 6,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Descreva o diorama',
                    hintText:
                        'Ex.: Ambiente de várzea com peixe-boi, aves e plantas aquáticas.',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Informe uma descrição para continuar.';
                    }
                    if (v.trim().length < 10) {
                      return 'A descrição deve ter pelo menos 10 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Mensagem de erro — ResultadoAPI<T> — Aula 3
              if (_resultado?.temErro == true)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _resultado!.mensagemErro!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              Semantics(
                label: _carregando
                    ? 'Analisando, aguarde'
                    : 'Botão analisar diorama',
                button: true,
                child: FilledButton.icon(
                  onPressed: _carregando ? null : _analisar,
                  icon: _carregando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.psychology),
                  label: Text(_carregando ? 'Analisando...' : 'Analisar diorama'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
