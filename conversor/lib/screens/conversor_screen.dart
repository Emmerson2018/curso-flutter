import 'package:flutter/material.dart';

import '../conversor/conversor.dart';

class ConversorScreen extends StatefulWidget {
  // O tipo é passado pela tela anterior.
  final TipoConversao tipo;

  const ConversorScreen({
    super.key,
    required this.tipo,
  });

  @override
  State<ConversorScreen> createState() => _ConversorScreenState();
}

class _ConversorScreenState extends State<ConversorScreen> {
  late String _unidadeOrigem;
  late String _unidadeDestino;

  double? _resultado;

  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _unidadeOrigem = widget.tipo.unidades.first;
    _unidadeDestino = widget.tipo.unidades[1];
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _calcular() {
    final textoDigitado = _ctrl.text.trim().replaceAll(',', '.');
    final valor = double.tryParse(textoDigitado);

    setState(() {
      if (valor == null) {
        _resultado = null;
        return;
      }

      _resultado = Conversor.converter(
        widget.tipo,
        valor,
        _unidadeOrigem,
        _unidadeDestino,
      );
    });
  }

  void _trocarUnidades() {
    setState(() {
      final temporaria = _unidadeOrigem;
      _unidadeOrigem = _unidadeDestino;
      _unidadeDestino = temporaria;
    });

    _calcular();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tipo.emoji} ${widget.tipo.titulo}'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: _ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Valor em $_unidadeOrigem',
              border: const OutlineInputBorder(),
              suffixText: _unidadeOrigem,
            ),
            onChanged: (_) => _calcular(),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _unidadeOrigem,
                  decoration: const InputDecoration(
                    labelText: 'De',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.tipo.unidades
                      .map(
                        (unidade) => DropdownMenuItem<String>(
                          value: unidade,
                          child: Text(unidade),
                        ),
                      )
                      .toList(),
                  onChanged: (valorSelecionado) {
                    if (valorSelecionado == null) return;

                    setState(() {
                      _unidadeOrigem = valorSelecionado;
                    });

                    _calcular();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton.filledTonal(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: _trocarUnidades,
                  tooltip: 'Trocar unidades',
                ),
              ),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _unidadeDestino,
                  decoration: const InputDecoration(
                    labelText: 'Para',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.tipo.unidades
                      .map(
                        (unidade) => DropdownMenuItem<String>(
                          value: unidade,
                          child: Text(unidade),
                        ),
                      )
                      .toList(),
                  onChanged: (valorSelecionado) {
                    if (valorSelecionado == null) return;

                    setState(() {
                      _unidadeDestino = valorSelecionado;
                    });

                    _calcular();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          if (_resultado != null)
            Card(
              color: colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_resultado!.toStringAsFixed(4)} $_unidadeDestino',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Digite um valor para visualizar a conversão.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}