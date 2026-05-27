import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal.dart';
import '../providers/goals_provider.dart';

class AddGoalScreen extends ConsumerStatefulWidget {
  const AddGoalScreen({super.key});
  @override
  ConsumerState<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends ConsumerState<AddGoalScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _titleCtrl  = TextEditingController();
  GoalCategory _cat = GoalCategory.pessoal;
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final goal = Goal(
      id:        DateTime.now().microsecondsSinceEpoch.toString(),
      title:     _titleCtrl.text.trim(),
      category:  _cat,
      deadline:  _deadline,
      createdAt: DateTime.now(),
    );
    await ref.read(goalsProvider.notifier).add(goal);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (d != null) setState(() => _deadline = d);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Meta'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Título
            TextFormField(
              controller: _titleCtrl,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Qual é sua meta?',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Digite uma meta' : null,
            ),
            const SizedBox(height: 20),
            // Categoria
            const Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: GoalCategory.values.map((cat) => ChoiceChip(
                avatar: Text(cat.emoji),
                label: Text(cat.label),
                selected: _cat == cat,
                onSelected: (_) => setState(() => _cat = cat),
              )).toList(),
            ),
            const SizedBox(height: 20),
            // Prazo
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Prazo', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${_deadline.day.toString().padLeft(2,'0')}/${_deadline.month.toString().padLeft(2,'0')}/${_deadline.year}',
                style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold),
              ),
              trailing: OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today, size: 16),
                label: const Text('Alterar'),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Salvar Meta', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}