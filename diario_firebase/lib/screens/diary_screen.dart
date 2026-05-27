import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/diary_entry.dart';
import '../services/auth_service.dart';
import '../services/diary_service.dart';

const _moods = ['😊', '😐', '😢', '😡', '🤩'];

class DiaryScreen extends StatefulWidget {
  final String uid;
  const DiaryScreen({super.key, required this.uid});
  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final _svc  = DiaryService();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Meu Diário'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Sair?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancelar')),
                    FilledButton(onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Sair')),
                  ],
                ),
              );
              if (ok == true) await _auth.signOut();
            },
          ),
        ],
      ),
      // StreamBuilder: reconstrói cada vez que o Firestore emite novos dados
      body: StreamBuilder<List<DiaryEntry>>(
        stream: _svc.watchEntries(widget.uid),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Erro: ${snap.error}'));
          }
          final entries = snap.data ?? [];
          if (entries.isEmpty) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('📝', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 12),
                Text('Nenhuma entrada ainda.',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline)),
                const SizedBox(height: 8),
                const Text('Toque em + para escrever sobre seu dia!',
                  style: TextStyle(color: Colors.grey)),
              ]),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 80),
            itemCount: entries.length,
            itemBuilder: (ctx, i) => _EntryCard(
              entry: entries[i],
              uid: widget.uid,
              svc: _svc,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova entrada'),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AddEntrySheet(uid: widget.uid, svc: _svc),
    );
  }
}

// ── Card de entrada ───────────────────────────────────────────────
class _EntryCard extends StatelessWidget {
  final DiaryEntry entry;
  final String uid;
  final DiaryService svc;
  const _EntryCard({required this.entry, required this.uid, required this.svc});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (entry.imageUrl != null)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              entry.imageUrl!,
              height: 160, width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(entry.mood, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                _formatDate(entry.date),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: () => svc.deleteEntry(uid, entry.id),
              ),
            ]),
            const SizedBox(height: 6),
            Text(entry.text, style: const TextStyle(fontSize: 15, height: 1.5)),
          ]),
        ),
      ]),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2,'0')}/${d.month.toString().padLeft(2,'0')}/${d.year}';
}

// ── Sheet de adicionar entrada ────────────────────────────────────
class _AddEntrySheet extends StatefulWidget {
  final String uid;
  final DiaryService svc;
  const _AddEntrySheet({required this.uid, required this.svc});
  @override
  State<_AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends State<_AddEntrySheet> {
  final _ctrl   = TextEditingController();
  String _mood  = '😊';
  File?  _image;
  bool   _saving = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  Future<void> _save() async {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() => _saving = true);
    try {
      String? url;
      if (_image != null) {
        url = await widget.svc.uploadImage(widget.uid, _image!);
      }
      await widget.svc.addEntry(
        widget.uid,
        DiaryEntry(
          id:       '',
          text:     _ctrl.text.trim(),
          date:     DateTime.now(),
          imageUrl: url,
          mood:     _mood,
        ),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Nova Entrada', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Seletor de humor
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: _moods.map((m) => GestureDetector(
            onTap: () => setState(() => _mood = m),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: m == _mood
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(m, style: const TextStyle(fontSize: 28)),
            ),
          )).toList()),
        const SizedBox(height: 14),
        TextField(
          controller: _ctrl,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Como foi seu dia?',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        if (_image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(_image!, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
        Row(children: [
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image_outlined),
            label: const Text('Adicionar foto'),
          ),
          const Spacer(),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(width: 18, height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Salvar'),
          ),
        ]),
      ]),
    );
  }
}