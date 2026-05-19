import 'package:drift/drift.dart';

import '../../features/finance/domain/finance_filter.dart';
import '../local/app_database.dart';

class TransactionRepository {
  final AppDatabase database;

  const TransactionRepository(this.database);

  Stream<List<FinanceTransaction>> watchFiltered({
    required FinanceFilterState filters,
  }) {
    final isIncome = switch (filters.kind) {
      TransactionKindFilter.all => null,
      TransactionKindFilter.income => true,
      TransactionKindFilter.expense => false,
    };

    return database.watchTransactions(
      start: filters.month.start,
      endExclusive: filters.month.endExclusive,
      isIncome: isIncome,
    );
  }

  Future<void> add({
    required String description,
    required double amount,
    required bool isIncome,
    required String category,
    required DateTime createdAt,
  }) async {
    await database.insertTransaction(
      FinanceTransactionsCompanion.insert(
        description: description,
        amount: amount,
        isIncome: isIncome,
        category: Value(category),
        createdAt: createdAt,
      ),
    );
  }

  Future<void> update({
    required FinanceTransaction transaction,
    required String description,
    required double amount,
    required bool isIncome,
    required String category,
    required DateTime createdAt,
  }) async {
    await database.updateTransaction(
      FinanceTransactionsCompanion(
        id: Value(transaction.id),
        description: Value(description),
        amount: Value(amount),
        isIncome: Value(isIncome),
        category: Value(category),
        createdAt: Value(createdAt),
      ),
    );
  }

  Future<void> remove(int id) async {
    await database.deleteTransactionById(id);
  }
}
