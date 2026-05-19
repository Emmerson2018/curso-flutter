import '../../../data/local/app_database.dart';

class BalanceSummary {
  final double income;
  final double expense;
  final double balance;

  const BalanceSummary({
    required this.income,
    required this.expense,
    required this.balance,
  });

  factory BalanceSummary.empty() {
    return const BalanceSummary(income: 0, expense: 0, balance: 0);
  }

  factory BalanceSummary.fromTransactions(List<FinanceTransaction> transactions) {
    double income = 0;
    double expense = 0;

    for (final transaction in transactions) {
      if (transaction.isIncome) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    return BalanceSummary(
      income: income,
      expense: expense,
      balance: income - expense,
    );
  }
}
