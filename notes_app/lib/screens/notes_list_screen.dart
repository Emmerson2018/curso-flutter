import 'package:flutter/material.dart';
import '../database/app_database.dart';
import 'note_edit_screen.dart';

class NotesListScreen extends StatefulWidget {
  final AppDatabase db;
  const NotesListScreen({super.key, required this.db});
  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  Stream<List<Note>> get _stream => _query.isEmpty
      ? widget.db.notesDao.watchAll()
      : widget.db.notesDao.watchSearch(_query);

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('📝 Minhas Notas'), centerTitle: true),
      body: Column(children: [
        // Barra de busca
        Padding(
          padding: const EdgeInsets.all(12),
          child: SearchBar(
            controller: _searchCtrl,
            hintText: 'Buscar notas...',
            leading: const Icon(Icons.search),
            trailing: [
              if (_query.isNotEmpty)
                IconButton(icon: const Icon(Icons.clear),
                  onPressed: () => setState(() {
                    _searchCtrl.clear(); _query = '';
                  }))
            ],
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          // StreamBuilder: reconstrói quando o Stream emite novo valor
          // O banco muda → Stream emite → UI atualiza. Zero setState manual!
          child: StreamBuilder<List<Note>>(
            stream: _stream,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final notes = snapshot.data ?? [];
              if (notes.isEmpty) {
                return Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.note_add_outlined, size: 72, color: scheme.outline),
                    const SizedBox(height: 12),
                    Text(_query.isEmpty ? 'Nenhuma nota ainda' : 'Nenhum resultado',
                      style: TextStyle(color: scheme.outline)),
                  ],
                ));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: notes.length,
                itemBuilder: (ctx, i) => _NoteCard(
                  note: notes[i], db: widget.db,
                ),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => NoteEditScreen(db: widget.db))),
        icon: const Icon(Icons.add),
        label: const Text('Nova Nota'),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note; final AppDatabase db;
  const _NoteCard({required this.note, required this.db});

  // Mapa de tag → cor (sem MaterialColor deprecated)
  static const _tagColors = <String, Color>{
    'work':     Color(0xFF3B82F6),
    'personal': Color(0xFF10B981),
    'study':    Color(0xFFF59E0B),
    'health':   Color(0xFFEF4444),
    'none':     Color(0xFF9CA3AF),
  };

  @override
  Widget build(BuildContext context) {
    final tagColor = _tagColors[note.tag] ?? const Color(0xFF9CA3AF);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(radius: 6, backgroundColor: tagColor),
        title: Text(note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(note.body, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: Icon(note.favorite ? Icons.favorite : Icons.favorite_border,
            color: note.favorite ? Colors.red : null),
          onPressed: () => db.notesDao.toggleFavorite(note),
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => NoteEditScreen(db: db, note: note))),
        onLongPress: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Excluir nota?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar')),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).colorScheme.error),
                onPressed: () async {
                  await db.notesDao.deleteNote(note.id);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Excluir')),
            ],
          )),
      ),
    );
  }
}