import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class FinanceTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().withLength(min: 1, max: 120)();

  RealColumn get amount => real()();

  BoolColumn get isIncome => boolean()();

  DateTimeColumn get createdAt => dateTime()();

  // Campo adicionado na versão 2 do schema.
  // O default evita erro ao migrar bases antigas que já tinham registros.
  TextColumn get category => text().withDefault(const Constant('Geral'))();
}

@DriftDatabase(tables: [FinanceTransactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
      },
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.addColumn(
            financeTransactions,
            financeTransactions.category as GeneratedColumn<Object>,
          );
        }
      },
    );
  }

  Stream<List<FinanceTransaction>> watchTransactions({
    required DateTime start,
    required DateTime endExclusive,
    bool? isIncome,
  }) {
    final query = select(financeTransactions)
      ..where(
        (table) =>
            table.createdAt.isBiggerOrEqualValue(start) &
            table.createdAt.isSmallerThanValue(endExclusive),
      )
      ..orderBy([
        (table) => OrderingTerm.desc(table.createdAt),
        (table) => OrderingTerm.desc(table.id),
      ]);

    if (isIncome != null) {
      query.where((table) => table.isIncome.equals(isIncome));
    }

    return query.watch();
  }

  Future<int> insertTransaction(FinanceTransactionsCompanion transaction) {
    return into(financeTransactions).insert(transaction);
  }

  Future<bool> updateTransaction(FinanceTransactionsCompanion transaction) {
    return update(financeTransactions).replace(transaction);
  }

  Future<int> deleteTransactionById(int id) {
    return (delete(financeTransactions)..where((table) => table.id.equals(id)))
        .go();
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'financas_offline');
}