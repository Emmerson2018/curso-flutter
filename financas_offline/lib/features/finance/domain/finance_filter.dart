class MonthFilter {
  final int year;
  final int month;

  const MonthFilter({
    required this.year,
    required this.month,
  });

  factory MonthFilter.current() {
    final now = DateTime.now();
    return MonthFilter(year: now.year, month: now.month);
  }

  DateTime get start => DateTime(year, month);

  DateTime get endExclusive => DateTime(year, month + 1);

  String get label {
    const monthNames = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${monthNames[month - 1]} de $year';
  }

  MonthFilter previous() {
    final date = DateTime(year, month - 1);
    return MonthFilter(year: date.year, month: date.month);
  }

  MonthFilter next() {
    final date = DateTime(year, month + 1);
    return MonthFilter(year: date.year, month: date.month);
  }
}

enum TransactionKindFilter {
  all,
  income,
  expense;

  String get label {
    return switch (this) {
      TransactionKindFilter.all => 'Todos',
      TransactionKindFilter.income => 'Receitas',
      TransactionKindFilter.expense => 'Despesas',
    };
  }
}

class FinanceFilterState {
  final MonthFilter month;
  final TransactionKindFilter kind;

  const FinanceFilterState({
    required this.month,
    required this.kind,
  });

  factory FinanceFilterState.initial() {
    return FinanceFilterState(
      month: MonthFilter.current(),
      kind: TransactionKindFilter.all,
    );
  }

  FinanceFilterState copyWith({
    MonthFilter? month,
    TransactionKindFilter? kind,
  }) {
    return FinanceFilterState(
      month: month ?? this.month,
      kind: kind ?? this.kind,
    );
  }
}
