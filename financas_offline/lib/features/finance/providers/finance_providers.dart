import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/app_database.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../domain/balance_summary.dart';
import '../domain/finance_filter.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return TransactionRepository(database);
});

final financeFilterProvider =
    NotifierProvider<FinanceFilterController, FinanceFilterState>(
  FinanceFilterController.new,
);

class FinanceFilterController extends Notifier<FinanceFilterState> {
  @override
  FinanceFilterState build() {
    return FinanceFilterState.initial();
  }

  void previousMonth() {
    state = state.copyWith(month: state.month.previous());
  }

  void nextMonth() {
    state = state.copyWith(month: state.month.next());
  }

  void setKind(TransactionKindFilter kind) {
    state = state.copyWith(kind: kind);
  }
}

final transactionsProvider = StreamProvider<List<FinanceTransaction>>((ref) {
  final filters = ref.watch(financeFilterProvider);
  final repository = ref.watch(transactionRepositoryProvider);

  return repository.watchFiltered(filters: filters);
});

final balanceSummaryProvider = Provider<BalanceSummary>((ref) {
  final transactionsAsync = ref.watch(transactionsProvider);

  return transactionsAsync.when(
    data: BalanceSummary.fromTransactions,
    loading: BalanceSummary.empty,
    error: (_, _) => BalanceSummary.empty(),
  );
});

const financeCategories = [
  'Geral',
  'Alimentação',
  'Transporte',
  'Educação',
  'Saúde',
  'Lazer',
  'Salário',
  'Serviços',
  'Outros',
];
