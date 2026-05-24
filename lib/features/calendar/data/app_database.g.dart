// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PoopLogsTable extends PoopLogs with TableInfo<$PoopLogsTable, PoopLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoopLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logDateMeta = const VerificationMeta(
    'logDate',
  );
  @override
  late final GeneratedColumn<String> logDate = GeneratedColumn<String>(
    'log_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _bristolTypeMeta = const VerificationMeta(
    'bristolType',
  );
  @override
  late final GeneratedColumn<int> bristolType = GeneratedColumn<int>(
    'bristol_type',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hydrationCupsMeta = const VerificationMeta(
    'hydrationCups',
  );
  @override
  late final GeneratedColumn<int> hydrationCups = GeneratedColumn<int>(
    'hydration_cups',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberGramsMeta = const VerificationMeta(
    'fiberGrams',
  );
  @override
  late final GeneratedColumn<int> fiberGrams = GeneratedColumn<int>(
    'fiber_grams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    occurredAt,
    logDate,
    bristolType,
    mood,
    notes,
    hydrationCups,
    fiberGrams,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poop_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PoopLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('log_date')) {
      context.handle(
        _logDateMeta,
        logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta),
      );
    } else if (isInserting) {
      context.missing(_logDateMeta);
    }
    if (data.containsKey('bristol_type')) {
      context.handle(
        _bristolTypeMeta,
        bristolType.isAcceptableOrUnknown(
          data['bristol_type']!,
          _bristolTypeMeta,
        ),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('hydration_cups')) {
      context.handle(
        _hydrationCupsMeta,
        hydrationCups.isAcceptableOrUnknown(
          data['hydration_cups']!,
          _hydrationCupsMeta,
        ),
      );
    }
    if (data.containsKey('fiber_grams')) {
      context.handle(
        _fiberGramsMeta,
        fiberGrams.isAcceptableOrUnknown(data['fiber_grams']!, _fiberGramsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PoopLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PoopLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      logDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_date'],
      )!,
      bristolType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bristol_type'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      hydrationCups: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hydration_cups'],
      ),
      fiberGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiber_grams'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PoopLogsTable createAlias(String alias) {
    return $PoopLogsTable(attachedDatabase, alias);
  }
}

class PoopLog extends DataClass implements Insertable<PoopLog> {
  final int id;
  final DateTime occurredAt;
  final String logDate;
  final int? bristolType;
  final String? mood;
  final String? notes;
  final int? hydrationCups;
  final int? fiberGrams;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PoopLog({
    required this.id,
    required this.occurredAt,
    required this.logDate,
    this.bristolType,
    this.mood,
    this.notes,
    this.hydrationCups,
    this.fiberGrams,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['log_date'] = Variable<String>(logDate);
    if (!nullToAbsent || bristolType != null) {
      map['bristol_type'] = Variable<int>(bristolType);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || hydrationCups != null) {
      map['hydration_cups'] = Variable<int>(hydrationCups);
    }
    if (!nullToAbsent || fiberGrams != null) {
      map['fiber_grams'] = Variable<int>(fiberGrams);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PoopLogsCompanion toCompanion(bool nullToAbsent) {
    return PoopLogsCompanion(
      id: Value(id),
      occurredAt: Value(occurredAt),
      logDate: Value(logDate),
      bristolType: bristolType == null && nullToAbsent
          ? const Value.absent()
          : Value(bristolType),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      hydrationCups: hydrationCups == null && nullToAbsent
          ? const Value.absent()
          : Value(hydrationCups),
      fiberGrams: fiberGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberGrams),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PoopLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PoopLog(
      id: serializer.fromJson<int>(json['id']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      logDate: serializer.fromJson<String>(json['logDate']),
      bristolType: serializer.fromJson<int?>(json['bristolType']),
      mood: serializer.fromJson<String?>(json['mood']),
      notes: serializer.fromJson<String?>(json['notes']),
      hydrationCups: serializer.fromJson<int?>(json['hydrationCups']),
      fiberGrams: serializer.fromJson<int?>(json['fiberGrams']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'logDate': serializer.toJson<String>(logDate),
      'bristolType': serializer.toJson<int?>(bristolType),
      'mood': serializer.toJson<String?>(mood),
      'notes': serializer.toJson<String?>(notes),
      'hydrationCups': serializer.toJson<int?>(hydrationCups),
      'fiberGrams': serializer.toJson<int?>(fiberGrams),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PoopLog copyWith({
    int? id,
    DateTime? occurredAt,
    String? logDate,
    Value<int?> bristolType = const Value.absent(),
    Value<String?> mood = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<int?> hydrationCups = const Value.absent(),
    Value<int?> fiberGrams = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PoopLog(
    id: id ?? this.id,
    occurredAt: occurredAt ?? this.occurredAt,
    logDate: logDate ?? this.logDate,
    bristolType: bristolType.present ? bristolType.value : this.bristolType,
    mood: mood.present ? mood.value : this.mood,
    notes: notes.present ? notes.value : this.notes,
    hydrationCups: hydrationCups.present
        ? hydrationCups.value
        : this.hydrationCups,
    fiberGrams: fiberGrams.present ? fiberGrams.value : this.fiberGrams,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PoopLog copyWithCompanion(PoopLogsCompanion data) {
    return PoopLog(
      id: data.id.present ? data.id.value : this.id,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      bristolType: data.bristolType.present
          ? data.bristolType.value
          : this.bristolType,
      mood: data.mood.present ? data.mood.value : this.mood,
      notes: data.notes.present ? data.notes.value : this.notes,
      hydrationCups: data.hydrationCups.present
          ? data.hydrationCups.value
          : this.hydrationCups,
      fiberGrams: data.fiberGrams.present
          ? data.fiberGrams.value
          : this.fiberGrams,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PoopLog(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('logDate: $logDate, ')
          ..write('bristolType: $bristolType, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('hydrationCups: $hydrationCups, ')
          ..write('fiberGrams: $fiberGrams, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    occurredAt,
    logDate,
    bristolType,
    mood,
    notes,
    hydrationCups,
    fiberGrams,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PoopLog &&
          other.id == this.id &&
          other.occurredAt == this.occurredAt &&
          other.logDate == this.logDate &&
          other.bristolType == this.bristolType &&
          other.mood == this.mood &&
          other.notes == this.notes &&
          other.hydrationCups == this.hydrationCups &&
          other.fiberGrams == this.fiberGrams &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PoopLogsCompanion extends UpdateCompanion<PoopLog> {
  final Value<int> id;
  final Value<DateTime> occurredAt;
  final Value<String> logDate;
  final Value<int?> bristolType;
  final Value<String?> mood;
  final Value<String?> notes;
  final Value<int?> hydrationCups;
  final Value<int?> fiberGrams;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PoopLogsCompanion({
    this.id = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.logDate = const Value.absent(),
    this.bristolType = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.hydrationCups = const Value.absent(),
    this.fiberGrams = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PoopLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime occurredAt,
    required String logDate,
    this.bristolType = const Value.absent(),
    this.mood = const Value.absent(),
    this.notes = const Value.absent(),
    this.hydrationCups = const Value.absent(),
    this.fiberGrams = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : occurredAt = Value(occurredAt),
       logDate = Value(logDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PoopLog> custom({
    Expression<int>? id,
    Expression<DateTime>? occurredAt,
    Expression<String>? logDate,
    Expression<int>? bristolType,
    Expression<String>? mood,
    Expression<String>? notes,
    Expression<int>? hydrationCups,
    Expression<int>? fiberGrams,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (logDate != null) 'log_date': logDate,
      if (bristolType != null) 'bristol_type': bristolType,
      if (mood != null) 'mood': mood,
      if (notes != null) 'notes': notes,
      if (hydrationCups != null) 'hydration_cups': hydrationCups,
      if (fiberGrams != null) 'fiber_grams': fiberGrams,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PoopLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? occurredAt,
    Value<String>? logDate,
    Value<int?>? bristolType,
    Value<String?>? mood,
    Value<String?>? notes,
    Value<int?>? hydrationCups,
    Value<int?>? fiberGrams,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PoopLogsCompanion(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      logDate: logDate ?? this.logDate,
      bristolType: bristolType ?? this.bristolType,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      hydrationCups: hydrationCups ?? this.hydrationCups,
      fiberGrams: fiberGrams ?? this.fiberGrams,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<String>(logDate.value);
    }
    if (bristolType.present) {
      map['bristol_type'] = Variable<int>(bristolType.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (hydrationCups.present) {
      map['hydration_cups'] = Variable<int>(hydrationCups.value);
    }
    if (fiberGrams.present) {
      map['fiber_grams'] = Variable<int>(fiberGrams.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoopLogsCompanion(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('logDate: $logDate, ')
          ..write('bristolType: $bristolType, ')
          ..write('mood: $mood, ')
          ..write('notes: $notes, ')
          ..write('hydrationCups: $hydrationCups, ')
          ..write('fiberGrams: $fiberGrams, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PoopLogsTable poopLogs = $PoopLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [poopLogs];
}

typedef $$PoopLogsTableCreateCompanionBuilder =
    PoopLogsCompanion Function({
      Value<int> id,
      required DateTime occurredAt,
      required String logDate,
      Value<int?> bristolType,
      Value<String?> mood,
      Value<String?> notes,
      Value<int?> hydrationCups,
      Value<int?> fiberGrams,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PoopLogsTableUpdateCompanionBuilder =
    PoopLogsCompanion Function({
      Value<int> id,
      Value<DateTime> occurredAt,
      Value<String> logDate,
      Value<int?> bristolType,
      Value<String?> mood,
      Value<String?> notes,
      Value<int?> hydrationCups,
      Value<int?> fiberGrams,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PoopLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PoopLogsTable> {
  $$PoopLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bristolType => $composableBuilder(
    column: $table.bristolType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hydrationCups => $composableBuilder(
    column: $table.hydrationCups,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiberGrams => $composableBuilder(
    column: $table.fiberGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PoopLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PoopLogsTable> {
  $$PoopLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bristolType => $composableBuilder(
    column: $table.bristolType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hydrationCups => $composableBuilder(
    column: $table.hydrationCups,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiberGrams => $composableBuilder(
    column: $table.fiberGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PoopLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PoopLogsTable> {
  $$PoopLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

  GeneratedColumn<int> get bristolType => $composableBuilder(
    column: $table.bristolType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get hydrationCups => $composableBuilder(
    column: $table.hydrationCups,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fiberGrams => $composableBuilder(
    column: $table.fiberGrams,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PoopLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PoopLogsTable,
          PoopLog,
          $$PoopLogsTableFilterComposer,
          $$PoopLogsTableOrderingComposer,
          $$PoopLogsTableAnnotationComposer,
          $$PoopLogsTableCreateCompanionBuilder,
          $$PoopLogsTableUpdateCompanionBuilder,
          (PoopLog, BaseReferences<_$AppDatabase, $PoopLogsTable, PoopLog>),
          PoopLog,
          PrefetchHooks Function()
        > {
  $$PoopLogsTableTableManager(_$AppDatabase db, $PoopLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PoopLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PoopLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PoopLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> logDate = const Value.absent(),
                Value<int?> bristolType = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> hydrationCups = const Value.absent(),
                Value<int?> fiberGrams = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PoopLogsCompanion(
                id: id,
                occurredAt: occurredAt,
                logDate: logDate,
                bristolType: bristolType,
                mood: mood,
                notes: notes,
                hydrationCups: hydrationCups,
                fiberGrams: fiberGrams,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime occurredAt,
                required String logDate,
                Value<int?> bristolType = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> hydrationCups = const Value.absent(),
                Value<int?> fiberGrams = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PoopLogsCompanion.insert(
                id: id,
                occurredAt: occurredAt,
                logDate: logDate,
                bristolType: bristolType,
                mood: mood,
                notes: notes,
                hydrationCups: hydrationCups,
                fiberGrams: fiberGrams,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PoopLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PoopLogsTable,
      PoopLog,
      $$PoopLogsTableFilterComposer,
      $$PoopLogsTableOrderingComposer,
      $$PoopLogsTableAnnotationComposer,
      $$PoopLogsTableCreateCompanionBuilder,
      $$PoopLogsTableUpdateCompanionBuilder,
      (PoopLog, BaseReferences<_$AppDatabase, $PoopLogsTable, PoopLog>),
      PoopLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PoopLogsTableTableManager get poopLogs =>
      $$PoopLogsTableTableManager(_db, _db.poopLogs);
}
