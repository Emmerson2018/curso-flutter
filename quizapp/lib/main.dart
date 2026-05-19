import 'dart:async';
import 'package:flutter/material.dart';
import 'models/pergunta.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const QuizScreen(),
  );
}

// Enum para controlar qual "tela" mostrar dentro do mesmo widget
enum Fase { boasVindas, pergunta, resultado }

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ── ESTADO DO QUIZ ───────────────────────────────────────
  Fase  _fase            = Fase.boasVindas;
  int   _indicePergunta  = 0;
  int   _pontuacao       = 0;
  int   _tempoRestante   = 20;
  int?  _respostaSelecionada;
  bool _respondeu        = false;

  // Timer é declarado fora dos métodos para poder cancelar
  Timer? _timer;

  // Getter para a pergunta atual
  Pergunta get _perguntaAtual => bancoPerguntasFlutter[_indicePergunta];
  bool     get _ehUltima      => _indicePergunta == bancoPerguntasFlutter.length - 1;

  // ── TIMER ────────────────────────────────────────────────
  void _iniciarTimer() {
    _timer?.cancel();
    setState(() => _tempoRestante = 20);

    // Timer.periodic executa a cada 1 segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_tempoRestante <= 1) {
        _responder(-1);   // -1 = tempo esgotado (resposta inválida)
      } else {
        setState(() => _tempoRestante--);
      }
    });
  }

  void _pararTimer() => _timer?.cancel();

  // ── FLUXO DO QUIZ ────────────────────────────────────────
  void _iniciarQuiz() {
    setState(() {
      _fase           = Fase.pergunta;
      _indicePergunta = 0;
      _pontuacao      = 0;
      _respondeu      = false;
      _respostaSelecionada = null;
    });
    _iniciarTimer();
  }

  void _responder(int indice) {
    if (_respondeu) return;   // ignora se já respondeu
    _pararTimer();

    final acertou = indice == _perguntaAtual.respostaCorreta;

    setState(() {
      _respondeu = true;
      _respostaSelecionada = indice;
      if (acertou) _pontuacao++;
    });

    // Aguarda 2s para o usuário ver o feedback, depois avança
    Future.delayed(const Duration(seconds: 2), _avancar);
  }

  void _avancar() {
    if (_ehUltima) {
      setState(() => _fase = Fase.resultado);
    } else {
      setState(() {
        _indicePergunta++;
        _respondeu = false;
        _respostaSelecionada = null;
      });
      _iniciarTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();   // SEMPRE cancele timers no dispose!
    super.dispose();
  }

  // ── BUILD PRINCIPAL — escolhe qual fase renderizar ───────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: switch (_fase) {
          Fase.boasVindas => _buildBoasVindas(),
          Fase.pergunta   => _buildPergunta(),
          Fase.resultado  => _buildResultado(),
        },
      ),
    );
  }

  // ── TELA DE BOAS-VINDAS ──────────────────────────────────
  Widget _buildBoasVindas() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🧠', style: TextStyle(fontSize: 80)),
            const SizedBox(height: 24),
            const Text('Quiz Flutter',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              '${bancoPerguntasFlutter.length} perguntas · 20 segundos cada',
              style: const TextStyle(color: Colors.white60, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _iniciarQuiz,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Começar!', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── TELA DA PERGUNTA ─────────────────────────────────────
  Widget _buildPergunta() {
    final total    = bancoPerguntasFlutter.length;
    final progresso = (_indicePergunta + 1) / total;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de progresso e timer
          Row(
            children: [
              Text('${_indicePergunta + 1}/$total',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Expanded(child: LinearProgressIndicator(value: progresso)),
              const SizedBox(width: 8),
              // AnimatedContainer: a COR muda com animação quando o tempo cai
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 44, height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Muda cor conforme o tempo restante
                  color: _tempoRestante > 10
                    ? Colors.green[700]
                    : _tempoRestante > 5
                      ? Colors.orange[700]
                      : Colors.red[700],
                ),
                child: Center(
                  child: Text('$_tempoRestante',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Texto da pergunta
          Text(
            _perguntaAtual.texto,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
          ),
          const SizedBox(height: 24),

          // Alternativas
          Expanded(
            child: ListView.separated(
              itemCount: _perguntaAtual.alternativas.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) => _buildAlternativa(i),
            ),
          ),

          // Explicação após responder
          if (_respondeu && _perguntaAtual.explicacao.isNotEmpty)
            AnimatedOpacity(
              opacity: _respondeu ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(_perguntaAtual.explicacao,
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Constrói uma alternativa com animação de cor
  Widget _buildAlternativa(int indice) {
    Color cor = Colors.white10;   // cor padrão

    if (_respondeu) {
      if (indice == _perguntaAtual.respostaCorreta) {
        cor = Colors.green[800]!;   // sempre mostra a correta em verde
      } else if (indice == _respostaSelecionada) {
        cor = Colors.red[800]!;     // a errada fica vermelha
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white24,
          child: Text('${String.fromCharCode(65 + indice)}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        title: Text(_perguntaAtual.alternativas[indice]),
        onTap: _respondeu ? null : () => _responder(indice),
      ),
    );
  }

  // ── TELA DE RESULTADO ────────────────────────────────────
  Widget _buildResultado() {
    final total      = bancoPerguntasFlutter.length;
    final pct        = (_pontuacao / total * 100).round();
    final emoji      = pct >= 80 ? '🏆' : pct >= 60 ? '👍' : '📚';
    final mensagem   = pct >= 80
        ? 'Excelente! Você domina Flutter!'
        : pct >= 60
          ? 'Bom trabalho! Continue estudando.'
          : 'Continue praticando — você vai chegar lá!';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            const Text('Resultado',
                style: TextStyle(fontSize: 16, color: Colors.white60)),
            Text('$_pontuacao / $total',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            Text('$pct% de aproveitamento',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            Text(mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _iniciarQuiz,
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Jogar Novamente', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}