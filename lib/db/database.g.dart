// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoriteTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, url];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites_table';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoriteTable extends DataClass implements Insertable<FavoriteTable> {
  final int id;
  final String name;
  final String url;
  const FavoriteTable(
      {required this.id, required this.name, required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    return map;
  }

  FavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesTableCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
    );
  }

  factory FavoriteTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteTable(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
    };
  }

  FavoriteTable copyWith({int? id, String? name, String? url}) => FavoriteTable(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );
  FavoriteTable copyWithCompanion(FavoritesTableCompanion data) {
    return FavoriteTable(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTable(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteTable &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url);
}

class FavoritesTableCompanion extends UpdateCompanion<FavoriteTable> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  const FavoritesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
  });
  FavoritesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
  })  : name = Value(name),
        url = Value(url);
  static Insertable<FavoriteTable> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
    });
  }

  FavoritesTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? url}) {
    return FavoritesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $HistoriesTableTable extends HistoriesTable
    with TableInfo<$HistoriesTableTable, HistoryTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _searchQueryMeta =
      const VerificationMeta('searchQuery');
  @override
  late final GeneratedColumn<String> searchQuery = GeneratedColumn<String>(
      'search_query', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, searchQuery];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'histories_table';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('search_query')) {
      context.handle(
          _searchQueryMeta,
          searchQuery.isAcceptableOrUnknown(
              data['search_query']!, _searchQueryMeta));
    } else if (isInserting) {
      context.missing(_searchQueryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      searchQuery: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}search_query'])!,
    );
  }

  @override
  $HistoriesTableTable createAlias(String alias) {
    return $HistoriesTableTable(attachedDatabase, alias);
  }
}

class HistoryTable extends DataClass implements Insertable<HistoryTable> {
  final int id;
  final String searchQuery;
  const HistoryTable({required this.id, required this.searchQuery});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['search_query'] = Variable<String>(searchQuery);
    return map;
  }

  HistoriesTableCompanion toCompanion(bool nullToAbsent) {
    return HistoriesTableCompanion(
      id: Value(id),
      searchQuery: Value(searchQuery),
    );
  }

  factory HistoryTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryTable(
      id: serializer.fromJson<int>(json['id']),
      searchQuery: serializer.fromJson<String>(json['searchQuery']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'searchQuery': serializer.toJson<String>(searchQuery),
    };
  }

  HistoryTable copyWith({int? id, String? searchQuery}) => HistoryTable(
        id: id ?? this.id,
        searchQuery: searchQuery ?? this.searchQuery,
      );
  HistoryTable copyWithCompanion(HistoriesTableCompanion data) {
    return HistoryTable(
      id: data.id.present ? data.id.value : this.id,
      searchQuery:
          data.searchQuery.present ? data.searchQuery.value : this.searchQuery,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryTable(')
          ..write('id: $id, ')
          ..write('searchQuery: $searchQuery')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, searchQuery);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryTable &&
          other.id == this.id &&
          other.searchQuery == this.searchQuery);
}

class HistoriesTableCompanion extends UpdateCompanion<HistoryTable> {
  final Value<int> id;
  final Value<String> searchQuery;
  const HistoriesTableCompanion({
    this.id = const Value.absent(),
    this.searchQuery = const Value.absent(),
  });
  HistoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String searchQuery,
  }) : searchQuery = Value(searchQuery);
  static Insertable<HistoryTable> custom({
    Expression<int>? id,
    Expression<String>? searchQuery,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (searchQuery != null) 'search_query': searchQuery,
    });
  }

  HistoriesTableCompanion copyWith(
      {Value<int>? id, Value<String>? searchQuery}) {
    return HistoriesTableCompanion(
      id: id ?? this.id,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (searchQuery.present) {
      map['search_query'] = Variable<String>(searchQuery.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('searchQuery: $searchQuery')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $HistoriesTableTable historiesTable = $HistoriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favoritesTable, historiesTable];
}

typedef $$FavoritesTableTableCreateCompanionBuilder = FavoritesTableCompanion
    Function({
  Value<int> id,
  required String name,
  required String url,
});
typedef $$FavoritesTableTableUpdateCompanionBuilder = FavoritesTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> url,
});

class $$FavoritesTableTableTableManager extends RootTableManager<
    _$Database,
    $FavoritesTableTable,
    FavoriteTable,
    $$FavoritesTableTableFilterComposer,
    $$FavoritesTableTableOrderingComposer,
    $$FavoritesTableTableCreateCompanionBuilder,
    $$FavoritesTableTableUpdateCompanionBuilder> {
  $$FavoritesTableTableTableManager(_$Database db, $FavoritesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FavoritesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FavoritesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> url = const Value.absent(),
          }) =>
              FavoritesTableCompanion(
            id: id,
            name: name,
            url: url,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String url,
          }) =>
              FavoritesTableCompanion.insert(
            id: id,
            name: name,
            url: url,
          ),
        ));
}

class $$FavoritesTableTableFilterComposer
    extends FilterComposer<_$Database, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FavoritesTableTableOrderingComposer
    extends OrderingComposer<_$Database, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$HistoriesTableTableCreateCompanionBuilder = HistoriesTableCompanion
    Function({
  Value<int> id,
  required String searchQuery,
});
typedef $$HistoriesTableTableUpdateCompanionBuilder = HistoriesTableCompanion
    Function({
  Value<int> id,
  Value<String> searchQuery,
});

class $$HistoriesTableTableTableManager extends RootTableManager<
    _$Database,
    $HistoriesTableTable,
    HistoryTable,
    $$HistoriesTableTableFilterComposer,
    $$HistoriesTableTableOrderingComposer,
    $$HistoriesTableTableCreateCompanionBuilder,
    $$HistoriesTableTableUpdateCompanionBuilder> {
  $$HistoriesTableTableTableManager(_$Database db, $HistoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HistoriesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$HistoriesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> searchQuery = const Value.absent(),
          }) =>
              HistoriesTableCompanion(
            id: id,
            searchQuery: searchQuery,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String searchQuery,
          }) =>
              HistoriesTableCompanion.insert(
            id: id,
            searchQuery: searchQuery,
          ),
        ));
}

class $$HistoriesTableTableFilterComposer
    extends FilterComposer<_$Database, $HistoriesTableTable> {
  $$HistoriesTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get searchQuery => $state.composableBuilder(
      column: $state.table.searchQuery,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HistoriesTableTableOrderingComposer
    extends OrderingComposer<_$Database, $HistoriesTableTable> {
  $$HistoriesTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get searchQuery => $state.composableBuilder(
      column: $state.table.searchQuery,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$HistoriesTableTableTableManager get historiesTable =>
      $$HistoriesTableTableTableManager(_db, _db.historiesTable);
}
