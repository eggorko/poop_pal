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
    final DateTime day = DateTime(2026, 5, 20);

    final PoopLog created = await repository.createLogForDay(day);
    final PoopLog? fetched = await repository.getLogForDay(day);

    expect(fetched, isNotNull);
    expect(fetched!.id, created.id);
    expect(fetched.occurredAt.year, 2026);
    expect(fetched.occurredAt.month, 5);
    expect(fetched.occurredAt.day, 20);
  });

  test('watches logs for a month', () async {
    await repository.createLogForDay(DateTime(2026, 5, 20));
    await repository.createLogForDay(DateTime(2026, 6, 1));

    final List<PoopLog> mayLogs = await repository
        .watchLogsForMonth(DateTime(2026, 5))
        .first;

    expect(mayLogs, hasLength(1));
    expect(mayLogs.single.occurredAt.month, 5);
  });

  test('deletes a log', () async {
    final PoopLog created = await repository.createLogForDay(
      DateTime(2026, 5, 20),
    );

    await repository.deleteLog(created.id);

    expect(await repository.getLogForDay(DateTime(2026, 5, 20)), isNull);
  });

  test('keeps one primary log per day', () async {
    final DateTime morning = DateTime(2026, 5, 20, 8);
    final DateTime evening = DateTime(2026, 5, 20, 19);

    final PoopLog first = await repository.createLogForDay(morning);
    final PoopLog second = await repository.createLogForDay(evening);
    final List<PoopLog> logs = await repository
        .watchLogsForMonth(DateTime(2026, 5))
        .first;

    expect(second.id, first.id);
    expect(logs, hasLength(1));
  });
}
