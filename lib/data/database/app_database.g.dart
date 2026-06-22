// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MaintenanceRecordsTable extends MaintenanceRecords
    with TableInfo<$MaintenanceRecordsTable, MaintenanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceCategory, String>
      category = GeneratedColumn<String>('category', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MaintenanceCategory>(
              $MaintenanceRecordsTable.$convertercategory);
  static const VerificationMeta _labNameMeta =
      const VerificationMeta('labName');
  @override
  late final GeneratedColumn<String> labName = GeneratedColumn<String>(
      'lab_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _maintenanceDateMeta =
      const VerificationMeta('maintenanceDate');
  @override
  late final GeneratedColumn<DateTime> maintenanceDate =
      GeneratedColumn<DateTime>('maintenance_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceStatus, String>
      status = GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MaintenanceStatus>(
              $MaintenanceRecordsTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, labName, maintenanceDate, dueDate, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_records';
  @override
  VerificationContext validateIntegrity(Insertable<MaintenanceRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lab_name')) {
      context.handle(_labNameMeta,
          labName.isAcceptableOrUnknown(data['lab_name']!, _labNameMeta));
    } else if (isInserting) {
      context.missing(_labNameMeta);
    }
    if (data.containsKey('maintenance_date')) {
      context.handle(
          _maintenanceDateMeta,
          maintenanceDate.isAcceptableOrUnknown(
              data['maintenance_date']!, _maintenanceDateMeta));
    } else if (isInserting) {
      context.missing(_maintenanceDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: $MaintenanceRecordsTable.$convertercategory.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      labName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lab_name'])!,
      maintenanceDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}maintenance_date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      status: $MaintenanceRecordsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
    );
  }

  @override
  $MaintenanceRecordsTable createAlias(String alias) {
    return $MaintenanceRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MaintenanceCategory, String, String>
      $convertercategory =
      const EnumNameConverter<MaintenanceCategory>(MaintenanceCategory.values);
  static JsonTypeConverter2<MaintenanceStatus, String, String>
      $converterstatus =
      const EnumNameConverter<MaintenanceStatus>(MaintenanceStatus.values);
}

class MaintenanceRecord extends DataClass
    implements Insertable<MaintenanceRecord> {
  final int id;
  final MaintenanceCategory category;
  final String labName;
  final DateTime maintenanceDate;
  final DateTime dueDate;
  final MaintenanceStatus status;
  const MaintenanceRecord(
      {required this.id,
      required this.category,
      required this.labName,
      required this.maintenanceDate,
      required this.dueDate,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['category'] = Variable<String>(
          $MaintenanceRecordsTable.$convertercategory.toSql(category));
    }
    map['lab_name'] = Variable<String>(labName);
    map['maintenance_date'] = Variable<DateTime>(maintenanceDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    {
      map['status'] = Variable<String>(
          $MaintenanceRecordsTable.$converterstatus.toSql(status));
    }
    return map;
  }

  MaintenanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceRecordsCompanion(
      id: Value(id),
      category: Value(category),
      labName: Value(labName),
      maintenanceDate: Value(maintenanceDate),
      dueDate: Value(dueDate),
      status: Value(status),
    );
  }

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceRecord(
      id: serializer.fromJson<int>(json['id']),
      category: $MaintenanceRecordsTable.$convertercategory
          .fromJson(serializer.fromJson<String>(json['category'])),
      labName: serializer.fromJson<String>(json['labName']),
      maintenanceDate: serializer.fromJson<DateTime>(json['maintenanceDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      status: $MaintenanceRecordsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(
          $MaintenanceRecordsTable.$convertercategory.toJson(category)),
      'labName': serializer.toJson<String>(labName),
      'maintenanceDate': serializer.toJson<DateTime>(maintenanceDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'status': serializer.toJson<String>(
          $MaintenanceRecordsTable.$converterstatus.toJson(status)),
    };
  }

  MaintenanceRecord copyWith(
          {int? id,
          MaintenanceCategory? category,
          String? labName,
          DateTime? maintenanceDate,
          DateTime? dueDate,
          MaintenanceStatus? status}) =>
      MaintenanceRecord(
        id: id ?? this.id,
        category: category ?? this.category,
        labName: labName ?? this.labName,
        maintenanceDate: maintenanceDate ?? this.maintenanceDate,
        dueDate: dueDate ?? this.dueDate,
        status: status ?? this.status,
      );
  MaintenanceRecord copyWithCompanion(MaintenanceRecordsCompanion data) {
    return MaintenanceRecord(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      labName: data.labName.present ? data.labName.value : this.labName,
      maintenanceDate: data.maintenanceDate.present
          ? data.maintenanceDate.value
          : this.maintenanceDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecord(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('labName: $labName, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, category, labName, maintenanceDate, dueDate, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceRecord &&
          other.id == this.id &&
          other.category == this.category &&
          other.labName == this.labName &&
          other.maintenanceDate == this.maintenanceDate &&
          other.dueDate == this.dueDate &&
          other.status == this.status);
}

class MaintenanceRecordsCompanion extends UpdateCompanion<MaintenanceRecord> {
  final Value<int> id;
  final Value<MaintenanceCategory> category;
  final Value<String> labName;
  final Value<DateTime> maintenanceDate;
  final Value<DateTime> dueDate;
  final Value<MaintenanceStatus> status;
  const MaintenanceRecordsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.labName = const Value.absent(),
    this.maintenanceDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  MaintenanceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required MaintenanceCategory category,
    required String labName,
    required DateTime maintenanceDate,
    required DateTime dueDate,
    required MaintenanceStatus status,
  })  : category = Value(category),
        labName = Value(labName),
        maintenanceDate = Value(maintenanceDate),
        dueDate = Value(dueDate),
        status = Value(status);
  static Insertable<MaintenanceRecord> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? labName,
    Expression<DateTime>? maintenanceDate,
    Expression<DateTime>? dueDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (labName != null) 'lab_name': labName,
      if (maintenanceDate != null) 'maintenance_date': maintenanceDate,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
    });
  }

  MaintenanceRecordsCompanion copyWith(
      {Value<int>? id,
      Value<MaintenanceCategory>? category,
      Value<String>? labName,
      Value<DateTime>? maintenanceDate,
      Value<DateTime>? dueDate,
      Value<MaintenanceStatus>? status}) {
    return MaintenanceRecordsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      labName: labName ?? this.labName,
      maintenanceDate: maintenanceDate ?? this.maintenanceDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $MaintenanceRecordsTable.$convertercategory.toSql(category.value));
    }
    if (labName.present) {
      map['lab_name'] = Variable<String>(labName.value);
    }
    if (maintenanceDate.present) {
      map['maintenance_date'] = Variable<DateTime>(maintenanceDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $MaintenanceRecordsTable.$converterstatus.toSql(status.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('labName: $labName, ')
          ..write('maintenanceDate: $maintenanceDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MaintenanceRecordsTable maintenanceRecords =
      $MaintenanceRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [maintenanceRecords];
}

typedef $$MaintenanceRecordsTableCreateCompanionBuilder
    = MaintenanceRecordsCompanion Function({
  Value<int> id,
  required MaintenanceCategory category,
  required String labName,
  required DateTime maintenanceDate,
  required DateTime dueDate,
  required MaintenanceStatus status,
});
typedef $$MaintenanceRecordsTableUpdateCompanionBuilder
    = MaintenanceRecordsCompanion Function({
  Value<int> id,
  Value<MaintenanceCategory> category,
  Value<String> labName,
  Value<DateTime> maintenanceDate,
  Value<DateTime> dueDate,
  Value<MaintenanceStatus> status,
});

class $$MaintenanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MaintenanceCategory, MaintenanceCategory,
          String>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get labName => $composableBuilder(
      column: $table.labName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get maintenanceDate => $composableBuilder(
      column: $table.maintenanceDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MaintenanceStatus, MaintenanceStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$MaintenanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get labName => $composableBuilder(
      column: $table.labName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get maintenanceDate => $composableBuilder(
      column: $table.maintenanceDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$MaintenanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MaintenanceCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get labName =>
      $composableBuilder(column: $table.labName, builder: (column) => column);

  GeneratedColumn<DateTime> get maintenanceDate => $composableBuilder(
      column: $table.maintenanceDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MaintenanceStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$MaintenanceRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MaintenanceRecordsTable,
    MaintenanceRecord,
    $$MaintenanceRecordsTableFilterComposer,
    $$MaintenanceRecordsTableOrderingComposer,
    $$MaintenanceRecordsTableAnnotationComposer,
    $$MaintenanceRecordsTableCreateCompanionBuilder,
    $$MaintenanceRecordsTableUpdateCompanionBuilder,
    (
      MaintenanceRecord,
      BaseReferences<_$AppDatabase, $MaintenanceRecordsTable, MaintenanceRecord>
    ),
    MaintenanceRecord,
    PrefetchHooks Function()> {
  $$MaintenanceRecordsTableTableManager(
      _$AppDatabase db, $MaintenanceRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<MaintenanceCategory> category = const Value.absent(),
            Value<String> labName = const Value.absent(),
            Value<DateTime> maintenanceDate = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<MaintenanceStatus> status = const Value.absent(),
          }) =>
              MaintenanceRecordsCompanion(
            id: id,
            category: category,
            labName: labName,
            maintenanceDate: maintenanceDate,
            dueDate: dueDate,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required MaintenanceCategory category,
            required String labName,
            required DateTime maintenanceDate,
            required DateTime dueDate,
            required MaintenanceStatus status,
          }) =>
              MaintenanceRecordsCompanion.insert(
            id: id,
            category: category,
            labName: labName,
            maintenanceDate: maintenanceDate,
            dueDate: dueDate,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MaintenanceRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MaintenanceRecordsTable,
    MaintenanceRecord,
    $$MaintenanceRecordsTableFilterComposer,
    $$MaintenanceRecordsTableOrderingComposer,
    $$MaintenanceRecordsTableAnnotationComposer,
    $$MaintenanceRecordsTableCreateCompanionBuilder,
    $$MaintenanceRecordsTableUpdateCompanionBuilder,
    (
      MaintenanceRecord,
      BaseReferences<_$AppDatabase, $MaintenanceRecordsTable, MaintenanceRecord>
    ),
    MaintenanceRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MaintenanceRecordsTableTableManager get maintenanceRecords =>
      $$MaintenanceRecordsTableTableManager(_db, _db.maintenanceRecords);
}
