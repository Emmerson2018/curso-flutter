import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value; // Importa o 'Value' necessário para o Companion
import '../database/app_database.dart';       // Ajuste o caminho para o seu arquivo do banco se necessário

class NoteEditScreen extends StatefulWidget {
  final AppDatabase db;
  final Note?        note;   // null = nova nota, Note = edição
  const NoteEditScreen({super.key, required this.db, this.note});
  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late final _titleCtrl = TextEditingController(text: widget.note?.title ?? '');
  late final _bodyCtrl  = TextEditingController(text: widget.note?.body ?? '');
  String _tag = 'none';
  bool   _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) _tag = widget.note!.tag;
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    final now = DateTime.now();
    if (widget.note == null) {
      await widget.db.notesDao.insertNote(NotesCompanion.insert(
        title: _titleCtrl.text.trim(), 
        body: _bodyCtrl.text,
        tag: Value(_tag), // Agora o 'Value' será reconhecido pelo compilador
        createdAt: now, 
        updatedAt: now,
      ));
    } else {
      await widget.db.notesDao.updateNote(widget.note!.copyWith(
        title: _titleCtrl.text.trim(), 
        body: _bodyCtrl.text,
        tag: _tag, 
        updatedAt: now,
      ));
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() { _titleCtrl.dispose(); _bodyCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nova Nota' : 'Editar Nota'),
        actions: [
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Salvando...' : 'Salvar')),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleCtrl, autofocus: true,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: const InputDecoration(
              hintText: 'Título', border: InputBorder.none),
          ),
          const Divider(),
          Wrap(spacing: 8, children: [
            'none', 'work', 'personal', 'study', 'health'
          ].map((t) => ChoiceChip(
            label: Text(t), selected: _tag == t,
            onSelected: (_) => setState(() => _tag = t),
          )).toList()),
          const SizedBox(height: 8),
          Expanded(child: TextField(
            controller: _bodyCtrl, maxLines: null, expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: 'Escreva sua nota...', border: InputBorder.none),
          )),
        ]),
      ),
    );
  }
}