import 'package:flutter/material.dart';

void main() => runApp(const ContadorApp());

class ContadorApp extends StatelessWidget {
  const ContadorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlacarScreen(),
    );
  }
}

class PlacarScreen extends StatefulWidget {
  const PlacarScreen({super.key});
  @override
  State<PlacarScreen> createState() => _PlacarScreenState();
}

class _PlacarScreenState extends State<PlacarScreen> {
  // ── ESTADO: variáveis que a UI usa ───────────────────────
  int _pontosA = 0;
  int _pontosB = 0;
  String _nomeA = 'Time A';
  String _nomeB = 'Time B';

  // ── GETTERS computados a partir do estado ────────────────
  // Getters são como variáveis, mas calculados sob demanda
  bool get _aVencendo  => _pontosA > _pontosB;
  bool get _bVencendo  => _pontosB > _pontosA;
  bool get _empate     => _pontosA == _pontosB;

  // ── MÉTODOS que modificam o estado ───────────────────────
  void _pontuar(String time, int delta) {
    setState(() {
      if (time == 'A') {
        _pontosA = (_pontosA + delta).clamp(0, 99);
        // clamp() garante que o valor fique entre 0 e 99
      } else {
        _pontosB = (_pontosB + delta).clamp(0, 99);
      }
    });
  }

  void _resetar() {
    setState(() {
      _pontosA = 0;
      _pontosB = 0;
    });
  }

  void _editarNome(String time) async {
    // showDialog mostra um pop-up. await espera o usuário fechar.
    final controller = TextEditingController(
        text: time == 'A' ? _nomeA : _nomeB);
    final resultado = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Nome do Time $time'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: const Text('OK')),
        ],
      ),
    );
    // Se o usuário confirmou (não cancelou), atualiza o nome
    if (resultado != null && resultado.isNotEmpty) {
      setState(() {
        if (time == 'A') _nomeA = resultado;
        else _nomeB = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('🏐 Placar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Resetar placar',
            onPressed: _resetar,
          )
        ],
      ),
      body: Column(
        children: [
          // Indicador de situação
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: _empate
                ? Colors.grey[800]
                : (_aVencendo ? Colors.indigo[900] : Colors.teal[900]),
            child: Text(
              // Operador ternário: condição ? valor_se_true : valor_se_false
              _empate ? '🤝 Empate!'
                : (_aVencendo ? '👑 $_nomeA está vencendo!'
                               : '👑 $_nomeB está vencendo!'),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          // Os dois times lado a lado
          Expanded(
            child: Row(
              children: [
                // Expanded faz o filho ocupar todo o espaço disponível
                Expanded(
                    child: _buildPlacarTime(_nomeA, _pontosA, 'A', Colors.indigo)),
                Container(width: 1, color: Colors.white12), // separador
                Expanded(
                    child: _buildPlacarTime(_nomeB, _pontosB, 'B', Colors.teal)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget de placar de um time — reusado para A e B
  Widget _buildPlacarTime(
      String nome, int pontos, String id, MaterialColor cor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GestureDetector detecta toques em qualquer widget
        GestureDetector(
          onTap: () => _editarNome(id),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nome,
                  style: TextStyle(
                      color: cor[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Icon(Icons.edit_outlined, size: 14, color: cor[200]),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          pontos.toString().padLeft(2, '0'),  // sempre 2 dígitos: 03, 15
          style: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w900,
            color: cor[100],
            height: 1,
          ),
        ),
        const SizedBox(height: 20),
        // Botão + ponto
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: cor[700]),
          onPressed: () => _pontuar(id, 1),
          child: const Icon(Icons.add, size: 28),
        ),
        const SizedBox(height: 8),
        // Botão - ponto (desabilitado quando pontos == 0)
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: cor[700]!)),
          onPressed: pontos > 0 ? () => _pontuar(id, -1) : null,
          // null em onPressed = botão desabilitado
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}