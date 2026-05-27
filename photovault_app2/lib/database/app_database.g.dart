// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$PhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $PhotosTable get photos => attachedDatabase.photos;
  PhotoDaoManager get managers => PhotoDaoManager(this);
}

class PhotoDaoManager {
  final _$PhotoDaoMixin _db;
  PhotoDaoManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db.attachedDatabase, _db.photos);
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioDescMeta = const VerificationMeta(
    'audioDesc',
  );
  @override
  late final GeneratedColumn<String> audioDesc = GeneratedColumn<String>(
    'audio_desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photographerNameMeta = const VerificationMeta(
    'photographerName',
  );
  @override
  late final GeneratedColumn<String> photographerName = GeneratedColumn<String>(
    'photographer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localPath,
    createdAt,
    caption,
    audioDesc,
    remoteUrl,
    photographerName,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Photo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('audio_desc')) {
      context.handle(
        _audioDescMeta,
        audioDesc.isAcceptableOrUnknown(data['audio_desc']!, _audioDescMeta),
      );
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('photographer_name')) {
      context.handle(
        _photographerNameMeta,
        photographerName.isAcceptableOrUnknown(
          data['photographer_name']!,
          _photographerNameMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      localPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}local_path'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      audioDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_desc'],
      ),
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      photographerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photographer_name'],
      ),
      isFavorite:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_favorite'],
          )!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class Photo extends DataClass implements Insertable<Photo> {
  final String id;
  final String localPath;
  final DateTime createdAt;
  final String? caption;
  final String? audioDesc;
  final String? remoteUrl;
  final String? photographerName;
  final bool isFavorite;
  const Photo({
    required this.id,
    required this.localPath,
    required this.createdAt,
    this.caption,
    this.audioDesc,
    this.remoteUrl,
    this.photographerName,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_path'] = Variable<String>(localPath);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    if (!nullToAbsent || audioDesc != null) {
      map['audio_desc'] = Variable<String>(audioDesc);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    if (!nullToAbsent || photographerName != null) {
      map['photographer_name'] = Variable<String>(photographerName);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      localPath: Value(localPath),
      createdAt: Value(createdAt),
      caption:
          caption == null && nullToAbsent
              ? const Value.absent()
              : Value(caption),
      audioDesc:
          audioDesc == null && nullToAbsent
              ? const Value.absent()
              : Value(audioDesc),
      remoteUrl:
          remoteUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(remoteUrl),
      photographerName:
          photographerName == null && nullToAbsent
              ? const Value.absent()
              : Value(photographerName),
      isFavorite: Value(isFavorite),
    );
  }

  factory Photo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      localPath: serializer.fromJson<String>(json['localPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      caption: serializer.fromJson<String?>(json['caption']),
      audioDesc: serializer.fromJson<String?>(json['audioDesc']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      photographerName: serializer.fromJson<String?>(json['photographerName']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localPath': serializer.toJson<String>(localPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'caption': serializer.toJson<String?>(caption),
      'audioDesc': serializer.toJson<String?>(audioDesc),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'photographerName': serializer.toJson<String?>(photographerName),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Photo copyWith({
    String? id,
    String? localPath,
    DateTime? createdAt,
    Value<String?> caption = const Value.absent(),
    Value<String?> audioDesc = const Value.absent(),
    Value<String?> remoteUrl = const Value.absent(),
    Value<String?> photographerName = const Value.absent(),
    bool? isFavorite,
  }) => Photo(
    id: id ?? this.id,
    localPath: localPath ?? this.localPath,
    createdAt: createdAt ?? this.createdAt,
    caption: caption.present ? caption.value : this.caption,
    audioDesc: audioDesc.present ? audioDesc.value : this.audioDesc,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    photographerName:
        photographerName.present
            ? photographerName.value
            : this.photographerName,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      caption: data.caption.present ? data.caption.value : this.caption,
      audioDesc: data.audioDesc.present ? data.audioDesc.value : this.audioDesc,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      photographerName:
          data.photographerName.present
              ? data.photographerName.value
              : this.photographerName,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('caption: $caption, ')
          ..write('audioDesc: $audioDesc, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('photographerName: $photographerName, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localPath,
    createdAt,
    caption,
    audioDesc,
    remoteUrl,
    photographerName,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.localPath == this.localPath &&
          other.createdAt == this.createdAt &&
          other.caption == this.caption &&
          other.audioDesc == this.audioDesc &&
          other.remoteUrl == this.remoteUrl &&
          other.photographerName == this.photographerName &&
          other.isFavorite == this.isFavorite);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<String> localPath;
  final Value<DateTime> createdAt;
  final Value<String?> caption;
  final Value<String?> audioDesc;
  final Value<String?> remoteUrl;
  final Value<String?> photographerName;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.localPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.caption = const Value.absent(),
    this.audioDesc = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.photographerName = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    required String id,
    required String localPath,
    required DateTime createdAt,
    this.caption = const Value.absent(),
    this.audioDesc = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.photographerName = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPath = Value(localPath),
       createdAt = Value(createdAt);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<String>? localPath,
    Expression<DateTime>? createdAt,
    Expression<String>? caption,
    Expression<String>? audioDesc,
    Expression<String>? remoteUrl,
    Expression<String>? photographerName,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localPath != null) 'local_path': localPath,
      if (createdAt != null) 'created_at': createdAt,
      if (caption != null) 'caption': caption,
      if (audioDesc != null) 'audio_desc': audioDesc,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (photographerName != null) 'photographer_name': photographerName,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? localPath,
    Value<DateTime>? createdAt,
    Value<String?>? caption,
    Value<String?>? audioDesc,
    Value<String?>? remoteUrl,
    Value<String?>? photographerName,
    Value<bool>? isFavorite,
    Value<int>? rowid,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      createdAt: createdAt ?? this.createdAt,
      caption: caption ?? this.caption,
      audioDesc: audioDesc ?? this.audioDesc,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      photographerName: photographerName ?? this.photographerName,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (audioDesc.present) {
      map['audio_desc'] = Variable<String>(audioDesc.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (photographerName.present) {
      map['photographer_name'] = Variable<String>(photographerName.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('caption: $caption, ')
          ..write('audioDesc: $audioDesc, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('photographerName: $photographerName, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final PhotoDao photoDao = PhotoDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [photos];
}

typedef $$PhotosTableCreateCompanionBuilder =
    PhotosCompanion Function({
      required String id,
      required String localPath,
      required DateTime createdAt,
      Value<String?> caption,
      Value<String?> audioDesc,
      Value<String?> remoteUrl,
      Value<String?> photographerName,
      Value<bool> isFavorite,
      Value<int> rowid,
    });
typedef $$PhotosTableUpdateCompanionBuilder =
    PhotosCompanion Function({
      Value<String> id,
      Value<String> localPath,
      Value<DateTime> createdAt,
      Value<String?> caption,
      Value<String?> audioDesc,
      Value<String?> remoteUrl,
      Value<String?> photographerName,
      Value<bool> isFavorite,
      Value<int> rowid,
    });

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioDesc => $composableBuilder(
    column: $table.audioDesc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photographerName => $composableBuilder(
    column: $table.photographerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioDesc => $composableBuilder(
    column: $table.audioDesc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photographerName => $composableBuilder(
    column: $table.photographerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<String> get audioDesc =>
      $composableBuilder(column: $table.audioDesc, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get photographerName => $composableBuilder(
    column: $table.photographerName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          Photo,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
          Photo,
          PrefetchHooks Function()
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<String?> audioDesc = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> photographerName = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                localPath: localPath,
                createdAt: createdAt,
                caption: caption,
                audioDesc: audioDesc,
                remoteUrl: remoteUrl,
                photographerName: photographerName,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localPath,
                required DateTime createdAt,
                Value<String?> caption = const Value.absent(),
                Value<String?> audioDesc = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<String?> photographerName = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                localPath: localPath,
                createdAt: createdAt,
                caption: caption,
                audioDesc: audioDesc,
                remoteUrl: remoteUrl,
                photographerName: photographerName,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      Photo,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (Photo, BaseReferences<_$AppDatabase, $PhotosTable, Photo>),
      Photo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
