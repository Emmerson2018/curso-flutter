import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/formatters/money_formatter.dart';
import '../../../../data/local/app_database.dart';
import '../../providers/finance_providers.dart';

class TransactionFormSheet extends ConsumerStatefulWidget {
  final FinanceTransaction? transaction;

  const TransactionFormSheet({super.key, this.transaction});

  @override
  ConsumerState<TransactionFormSheet> createState() => _TransactionFormSheetState();
}

class _TransactionFormSheetState extends ConsumerState<TransactionFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  late bool _isIncome;
  late String _category;
  late DateTime _createdAt;
  bool _saving = false;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    final transaction = widget.transaction;
    _descriptionController.text = transaction?.description ?? '';
    _amountController.text = transaction == null ? '' : transaction.amount.toStringAsFixed(2);
    _isIncome = transaction?.isIncome ?? false;
    _category = transaction?.category ?? financeCategories.first;
    _createdAt = transaction?.createdAt ?? DateTime.now();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected == null) return;
    setState(() {
      _createdAt = DateTime(selected.year, selected.month, selected.day, _createdAt.hour, _createdAt.minute);
    });
  }

  Future<void> _save() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _saving) return;
    final amount = MoneyFormatter.parse(_amountController.text);
    if (amount == null) return;

    setState(() => _saving = true);
    final repository = ref.read(transactionRepositoryProvider);

    try {
      if (_isEditing) {
        await repository.update(
          transaction: widget.transaction!,
          description: _descriptionController.text.trim(),
          amount: amount,
          isIncome: _isIncome,
          category: _category,
          createdAt: _createdAt,
        );
      } else {
        await repository.add(
          description: _descriptionController.text.trim(),
          amount: amount,
          isIncome: _isIncome,
          category: _category,
          createdAt: _createdAt,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar lançamento: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              _isEditing ? 'Editar lançamento' : 'Novo lançamento',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Despesa'), icon: Icon(Icons.arrow_downward)),
                ButtonSegment(value: true, label: Text('Receita'), icon: Icon(Icons.arrow_upward)),
              ],
              selected: {_isIncome},
              onSelectionChanged: (selected) {
                setState(() => _isIncome = selected.first);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição', border: OutlineInputBorder()),
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Informe uma descrição.';
                if (text.length < 3) return 'A descrição deve ter pelo menos 3 caracteres.';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Valor',
                hintText: 'Ex.: 120,50',
                border: OutlineInputBorder(),
                prefixText: 'R\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
              validator: (value) {
                final amount = MoneyFormatter.parse(value ?? '');
                if (amount == null || amount <= 0) return 'Informe um valor maior que zero.';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Categoria', border: OutlineInputBorder()),
              items: financeCategories
                  .map((category) => DropdownMenuItem<String>(value: category, child: Text(category)))
                  .toList(),
              onChanged: (selected) {
                if (selected == null) return;
                setState(() => _category = selected);
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _selectDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(_formatDate(_createdAt)),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(_saving ? 'Salvando...' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
