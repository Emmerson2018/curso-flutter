import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/formatters/money_formatter.dart';
import '../../../../data/local/app_database.dart';
import '../../providers/finance_providers.dart';
import 'transaction_form_sheet.dart';

class TransactionTile extends ConsumerWidget {
  final FinanceTransaction transaction;

  const TransactionTile({super.key, required this.transaction});

  Future<void> _openEditForm(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TransactionFormSheet(transaction: transaction),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir lançamento'),
          content: Text('Deseja excluir "${transaction.description}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;
    await ref.read(transactionRepositoryProvider).remove(transaction.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIncome = transaction.isIncome;
    final amountColor = isIncome ? Colors.green.shade700 : Colors.red.shade700;
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(transaction.description),
        subtitle: Text('${transaction.category} • ${_formatDate(transaction.createdAt)}'),
        trailing: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              MoneyFormatter.format(transaction.amount),
              style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton<_TransactionAction>(
              onSelected: (action) {
                switch (action) {
                  case _TransactionAction.edit:
                    _openEditForm(context);
                  case _TransactionAction.delete:
                    _confirmDelete(context, ref);
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(value: _TransactionAction.edit, child: Text('Editar')),
                  PopupMenuItem(value: _TransactionAction.delete, child: Text('Excluir')),
                ];
              },
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

enum _TransactionAction { edit, delete }
