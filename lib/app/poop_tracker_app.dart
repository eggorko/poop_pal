import 'package:flutter/material.dart';

import '../features/calendar/data/app_database.dart';
import '../features/calendar/data/poop_log_repository.dart';
import '../features/calendar/screens/poop_calendar_screen.dart';
import 'theme.dart';

class PoopTrackerApp extends StatefulWidget {
  const PoopTrackerApp({super.key, this.repository});

  final PoopLogRepository? repository;

  @override
  State<PoopTrackerApp> createState() => _PoopTrackerAppState();
}

class _PoopTrackerAppState extends State<PoopTrackerApp> {
  late final PoopLogRepository _repository;
  late final bool _ownsRepository;

  @override
  void initState() {
    super.initState();
    _ownsRepository = widget.repository == null;
    _repository = widget.repository ?? PoopLogRepository(AppDatabase());
  }

  @override
  void dispose() {
    if (_ownsRepository) {
      _repository.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoopPal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: PoopCalendarScreen(repository: _repository),
    );
  }
}
