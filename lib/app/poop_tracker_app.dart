import 'package:flutter/material.dart';

import '../features/calendar/screens/poop_calendar_screen.dart';
import 'theme.dart';

class PoopTrackerApp extends StatelessWidget {
  const PoopTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoopPal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PoopCalendarScreen(),
    );
  }
}
