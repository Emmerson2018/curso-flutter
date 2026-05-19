import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/finance_providers.dart';
import 'widgets/balance_card.dart';
import 'widgets/balance_chart.dart';
import 'widgets/empty_transactions.dart';
import 'widgets/filter_bar.dart';
import 'widgets/transaction_form_sheet.dart';
import 'widgets/transaction_tile.dart';

class FinancePage extends ConsumerWidget {
  const FinancePage({super.key});

  Future<void> _openCreateForm(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const TransactionFormSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final summary = ref.watch(balanceSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanças Offline'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Novo'),
      ),
      body: transactionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _FinanceErrorView(error: error),
        data: (transactions) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(transactionsProvider);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              children: [
                const FilterBar(),
                const SizedBox(height: 12),
                BalanceCard(summary: summary),
                const SizedBox(height: 12),
                BalanceChart(transactions: transactions),
                const SizedBox(height: 16),
                Text(
                  'Lançamentos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (transactions.isEmpty)
                  const EmptyTransactions()
                else
                  for (final transaction in transactions)
                    TransactionTile(transaction: transaction),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FinanceErrorView extends ConsumerWidget {
  final Object error;

  const _FinanceErrorView({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(
              'Não foi possível carregar os lançamentos.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => ref.invalidate(transactionsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
