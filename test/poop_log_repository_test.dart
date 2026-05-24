import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pt/features/calendar/data/app_database.dart' hide PoopLog;
import 'package:pt/features/calendar/data/poop_log_repository.dart';
import 'package:pt/features/calendar/models/poop_log.dart';

void main() {
  late AppDatabase database;
  late PoopLogRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = PoopLogRepository(database);
  });

  tearDown(() async {
    await repository.close();
  });

  test('creates and fetches a log for a day', () async {
    final DateTime day = DateTime.now().subtract(const Duration(days: 1));

    final PoopLog created = await repository.createLogForDay(day);
    final PoopLog? fetched = await repository.getLogForDay(day);

    expect(fetched, isNotNull);
    expect(fetched!.id, created.id);
    expect(fetched.occurredAt.year, day.year);
    expect(fetched.occurredAt.month, day.month);
    expect(fetched.occurredAt.day, day.day);
  });

  test('watches logs for a month', () async {
    final DateTime today = DateTime.now();
    final DateTime month = DateTime(today.year, today.month - 1);
    final DateTime dayInMonth = DateTime(month.year, month.month, 15);
    final DateTime dayOutsideMonth = DateTime(month.year, month.month - 1, 15);

    await repository.createLogForDay(dayInMonth);
    await repository.createLogForDay(dayOutsideMonth);

    final List<PoopLog> monthLogs = await repository
        .watchLogsForMonth(month)
        .first;

    expect(monthLogs, hasLength(1));
    expect(monthLogs.single.occurredAt.month, month.month);
  });

  test('deletes a log', () async {
    final DateTime day = DateTime.now().subtract(const Duration(days: 1));
    final PoopLog created = await repository.createLogForDay(day);

    await repository.deleteLog(created.id);

    expect(await repository.getLogForDay(day), isNull);
  });

  test('keeps one primary log per day', () async {
    final DateTime day = DateTime.now().subtract(const Duration(days: 1));
    final DateTime morning = DateTime(day.year, day.month, day.day, 8);
    final DateTime evening = DateTime(day.year, day.month, day.day, 19);

    final PoopLog first = await repository.createLogForDay(morning);
    final PoopLog second = await repository.createLogForDay(evening);
    final List<PoopLog> logs = await repository
        .watchLogsForMonth(DateTime(day.year, day.month))
        .first;

    expect(second.id, first.id);
    expect(logs, hasLength(1));
  });

  test('rejects future logs', () async {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    expect(
      () => repository.createLogForDay(tomorrow),
      throwsA(isA<ArgumentError>()),
    );
    expect(await repository.getLogForDay(tomorrow), isNull);
  });

  test('rejects moving logs to a future date', () async {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    final PoopLog log = await repository.createLogForDay(yesterday);

    expect(
      () => repository.updateLog(log.copyWith(occurredAt: tomorrow)),
      throwsA(isA<ArgumentError>()),
    );
  });
}
