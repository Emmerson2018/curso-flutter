import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
part 'app_database.g.dart';   // gerado por: flutter pub run build_runner build

// ── Definição da tabela como classe Dart ─────────────────
class Notes extends Table {
  IntColumn    get id        => integer().autoIncrement()();
  TextColumn   get title     => text().withLength(min: 1, max: 200)();
  TextColumn   get body      => text()();
  TextColumn   get tag       => text().withDefault(const Constant('none'))();
  BoolColumn   get favorite  => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase>
    with _$NotesDaoMixin {
  NotesDao(super.db);

  // watch(): Stream reativo — emite nova lista sempre que o banco muda
  Stream<List<Note>> watchAll() {
    return (select(notes)
      ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
      .watch();
  }

  // Busca por título ou corpo (case-insensitive)
  Stream<List<Note>> watchSearch(String query) {
    final q = '%$query%';
    return (select(notes)
      ..where((n) => n.title.like(q) | n.body.like(q))
      ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
      .watch();
  }

  Stream<List<Note>> watchFavorites() {
    return (select(notes)
      ..where((n) => n.favorite.equals(true)))
      .watch();
  }

  Future<int>  insertNote(NotesCompanion entry)   => into(notes).insert(entry);
  Future<bool> updateNote(Note note)               => update(notes).replace(note);
  Future<int>  deleteNote(int id) =>
    (delete(notes)..where((n) => n.id.equals(id))).go();

  Future<void> toggleFavorite(Note note) =>
    updateNote(note.copyWith(favorite: !note.favorite));
}

@DriftDatabase(tables: [Notes], daos: [NotesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  @override int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => await m.createAll(),
    onUpgrade: (m, from, to) async {
      // Exemplo: se atualizar para v2, adicione coluna nova
      // if (from < 2) await m.addColumn(notes, notes.pinned);
    },
  );
}

QueryExecutor _open() {
  return driftDatabase(name: 'notes.db');
}