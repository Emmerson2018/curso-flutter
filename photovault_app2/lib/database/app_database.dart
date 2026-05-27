import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart'; // driftDatabase()
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

// ── Tabela ───────────────────────────────────────────────
class Photos extends Table {
  TextColumn     get id               => text()();
  TextColumn     get localPath        => text()();
  DateTimeColumn get createdAt        => dateTime()();
  TextColumn     get caption          => text().nullable()();
  TextColumn     get audioDesc        => text().nullable()();
  TextColumn     get remoteUrl        => text().nullable()();
  TextColumn     get photographerName => text().nullable()();
  BoolColumn     get isFavorite       =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// ── DAO ──────────────────────────────────────────────────
@DriftAccessor(tables: [Photos])
class PhotoDao extends DatabaseAccessor<AppDatabase> with _$PhotoDaoMixin {
  PhotoDao(super.db);

  Stream<List<Photo>> watchAllPhotos() =>
      (select(photos)..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
          .watch();

  Future<List<Photo>> getAllPhotos() =>
      (select(photos)..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
          .get();

  Future<Photo?> getById(String id) =>
      (select(photos)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<void> insertPhoto(PhotosCompanion c) =>
      into(photos).insert(c, mode: InsertMode.insertOrReplace);

  Future<void> updatePhoto(PhotosCompanion c) =>
      (update(photos)..where((p) => p.id.equals(c.id.value))).write(c);

  Future<int> deletePhoto(String id) =>
      (delete(photos)..where((p) => p.id.equals(id))).go();

  Stream<List<Photo>> watchFavorites() =>
      (select(photos)
            ..where((p) => p.isFavorite.equals(true))
            ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
          .watch();
}

// ── Database ─────────────────────────────────────────────
@DriftDatabase(tables: [Photos], daos: [PhotoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {},
  );
}

// drift_flutter 0.2.8+: usa driftDatabase() em vez de DriftNativeStorage
QueryExecutor _openConnection() => driftDatabase(name: 'photo_vault');

// ── Provider ─────────────────────────────────────────────
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
