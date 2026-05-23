import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class PoopLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get logDate => text().unique()();
  IntColumn get bristolType => integer().nullable()();
  TextColumn get mood => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get hydrationCups => integer().nullable()();
  IntColumn get fiberGrams => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [PoopLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File file = File(p.join(appDirectory.path, 'poop_pal.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
