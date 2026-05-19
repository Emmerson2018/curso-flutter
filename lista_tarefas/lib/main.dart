import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/tarefa.dart';

void main() => runApp(const TarefasApp());

class TarefasApp extends StatelessWidget {
  const TarefasApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: const TarefasScreen(),
  );
}

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({super.key});
  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  List<Tarefa> _tarefas = [];
  Categoria? _filtro;  // null = mostrar todas

  // initState é chamado UMA VEZ quando o widget é criado
  @override
  void initState() {
    super.initState();
    _carregarTarefas();   // carrega do disco ao abrir
  }

  // Getters computados — a lista filtrada é recalculada automaticamente
  List<Tarefa> get _tarefasFiltradas => _filtro == null
      ? _tarefas
      : _tarefas.where((t) => t.categoria == _filtro).toList();

  int get _pendentes => _tarefas.where((t) => !t.concluida).length;

  // ── PERSISTÊNCIA ────────────────────────────────────────
  Future<void> _carregarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    final json  = prefs.getString('tarefas');
    if (json != null) {
      setState(() => _tarefas = Tarefa.listaDeJson(json));
    }
  }

  Future<void> _salvarTarefas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tarefas', Tarefa.listaParaJson(_tarefas));
  }

  // ── AÇÕES ────────────────────────────────────────────────
  void _adicionarTarefa(String titulo, Categoria cat) {
    setState(() {
      _tarefas.insert(0, Tarefa(
        id:        DateTime.now().millisecondsSinceEpoch.toString(),
        titulo:    titulo,
        categoria: cat,
        criadaEm:  DateTime.now(),
      ));
    });
    _salvarTarefas();
  }

  void _alternarConclusao(Tarefa tarefa) {
    setState(() {
      final idx = _tarefas.indexWhere((t) => t.id == tarefa.id);
      _tarefas[idx] = tarefa.copyWith(concluida: !tarefa.concluida);
    });
    _salvarTarefas();
  }

  void _removerTarefa(Tarefa tarefa) {
    setState(() => _tarefas.removeWhere((t) => t.id == tarefa.id));
    _salvarTarefas();
    // SnackBar com opção de desfazer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa "${tarefa.titulo}" removida'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() => _tarefas.add(tarefa));
            _salvarTarefas();
          },
        ),
      ),
    );
  }

  // ── DIÁLOGO PARA NOVA TAREFA ─────────────────────────────
  void _abrirFormulario() {
    final tituloCtrl = TextEditingController();
    var catSelecionada = Categoria.pessoal;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // permite o sheet crescer com o teclado
      builder: (ctx) => StatefulBuilder(
        // StatefulBuilder permite setState dentro do sheet
        builder: (ctx2, setStateLocal) => Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 16,
            bottom: MediaQuery.of(ctx2).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nova Tarefa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: tituloCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'O que fazer?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: Categoria.values.map((cat) {
                  final selecionada = catSelecionada == cat;
                  return ChoiceChip(
                    label: Text('${cat.emoji} ${cat.nome}'),
                    selected: selecionada,
                    onSelected: (_) =>
                        setStateLocal(() => catSelecionada = cat),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (tituloCtrl.text.trim().isNotEmpty) {
                      _adicionarTarefa(tituloCtrl.text.trim(), catSelecionada);
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('Adicionar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pendentes > 0
            ? 'Tarefas ($_pendentes pendentes)'
            : 'Tudo concluído! 🎉',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filtro de categorias
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Todas'),
                  selected: _filtro == null,
                  onSelected: (_) => setState(() => _filtro = null),
                ),
                const SizedBox(width: 6),
                ...Categoria.values.map((cat) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: FilterChip(
                    label: Text('${cat.emoji} ${cat.nome}'),
                    selected: _filtro == cat,
                    onSelected: (_) => setState(() => _filtro = cat),
                  ),
                )),
              ],
            ),
          ),

          // Lista de tarefas
          Expanded(
            child: _tarefasFiltradas.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('📋', style: TextStyle(fontSize: 48)),
                      SizedBox(height: 8),
                      Text('Nenhuma tarefa aqui!',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _tarefasFiltradas.length,
                  itemBuilder: (ctx, idx) {
                    final tarefa = _tarefasFiltradas[idx];
                    // Dismissible: arraste para remover (swipe to delete)
                    return Dismissible(
                      key: Key(tarefa.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _removerTarefa(tarefa),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Checkbox(
                            value: tarefa.concluida,
                            onChanged: (_) => _alternarConclusao(tarefa),
                          ),
                          title: Text(
                            tarefa.titulo,
                            style: TextStyle(
                              decoration: tarefa.concluida
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: tarefa.concluida ? Colors.grey : null,
                            ),
                          ),
                          trailing: Text(
                            '${tarefa.categoria.emoji}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormulario,
        icon: const Icon(Icons.add),
        label: const Text('Nova Tarefa'),
      ),
    );
  }
}