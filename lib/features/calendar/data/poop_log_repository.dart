import 'package:drift/drift.dart';

import '../../../shared/date_helpers.dart';
import '../models/poop_log.dart' as domain;
import 'app_database.dart';

class PoopLogRepository {
  PoopLogRepository(this._database);

  final AppDatabase _database;

  Stream<List<domain.PoopLog>> watchLogsForMonth(DateTime month) {
    final DateTime start = DateTime(month.year, month.month);
    final DateTime end = DateTime(month.year, month.month + 1);

    final query = _database.select(_database.poopLogs)
      ..where(
        (row) =>
            row.occurredAt.isBiggerOrEqualValue(start) &
            row.occurredAt.isSmallerThanValue(end),
      )
      ..orderBy([(row) => OrderingTerm.asc(row.occurredAt)]);

    return query.watch().map(
      (List<PoopLog> logs) => logs.map(_mapLog).toList(growable: false),
    );
  }

  Future<domain.PoopLog?> getLogForDay(DateTime day) async {
    final String key = _logDateKey(day);
    final query = _database.select(_database.poopLogs)
      ..where((row) => row.logDate.equals(key))
      ..limit(1);
    final PoopLog? log = await query.getSingleOrNull();

    return log == null ? null : _mapLog(log);
  }

  Future<domain.PoopLog> createLogForDay(DateTime day) async {
    final DateTime now = DateTime.now();
    final DateTime selectedDate = dateOnly(day);
    final DateTime occurredAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
      now.millisecond,
      now.microsecond,
    );
    final String key = _logDateKey(selectedDate);

    final existing = await getLogForDay(selectedDate);
    if (existing != null) {
      return existing;
    }

    final int id = await _database
        .into(_database.poopLogs)
        .insert(
          PoopLogsCompanion.insert(
            occurredAt: occurredAt,
            logDate: key,
            createdAt: now,
            updatedAt: now,
          ),
        );

    final PoopLog log = await (_database.select(
      _database.poopLogs,
    )..where((row) => row.id.equals(id))).getSingle();

    return _mapLog(log);
  }

  Future<domain.PoopLog> updateLog(domain.PoopLog log) async {
    final DateTime now = DateTime.now();
    final PoopLogsCompanion companion = PoopLogsCompanion(
      id: Value(log.id),
      occurredAt: Value(log.occurredAt),
      logDate: Value(_logDateKey(log.occurredAt)),
      bristolType: Value(log.bristolType),
      mood: Value(log.mood),
      notes: Value(log.notes),
      hydrationCups: Value(log.hydrationCups),
      fiberGrams: Value(log.fiberGrams),
      createdAt: Value(log.createdAt),
      updatedAt: Value(now),
    );

    await _database.update(_database.poopLogs).replace(companion);
    final PoopLog updated = await (_database.select(
      _database.poopLogs,
    )..where((row) => row.id.equals(log.id))).getSingle();

    return _mapLog(updated);
  }

  Future<void> deleteLog(int id) {
    return (_database.delete(
      _database.poopLogs,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<void> close() => _database.close();

  domain.PoopLog _mapLog(PoopLog log) {
    return domain.PoopLog(
      id: log.id,
      occurredAt: log.occurredAt,
      bristolType: log.bristolType,
      mood: log.mood,
      notes: log.notes,
      hydrationCups: log.hydrationCups,
      fiberGrams: log.fiberGrams,
      createdAt: log.createdAt,
      updatedAt: log.updatedAt,
    );
  }
}

String _logDateKey(DateTime date) {
  final DateTime normalized = dateOnly(date);
  final String year = normalized.year.toString().padLeft(4, '0');
  final String month = normalized.month.toString().padLeft(2, '0');
  final String day = normalized.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}
