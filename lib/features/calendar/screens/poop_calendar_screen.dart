import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/confetti_config.dart';
import '../../../app/feature_flags.dart';
import '../data/poop_log_repository.dart';
import '../models/poop_log.dart';
import '../../../shared/app_assets.dart';
import '../../../shared/date_helpers.dart';
import '../widgets/app_header.dart';
import '../widgets/bristol_section.dart';
import '../widgets/calendar_section.dart';
import '../widgets/mood_section.dart';
import '../widgets/notes_card.dart';
import '../widgets/poop_bottom_navigation.dart';
import '../widgets/progress_card.dart';
import '../widgets/selected_day_panel.dart';

class PoopCalendarScreen extends StatefulWidget {
  const PoopCalendarScreen({
    required this.repository,
    required this.featureFlags,
    this.confettiConfig = appConfettiConfig,
    super.key,
  });

  final PoopLogRepository repository;
  final FeatureFlags featureFlags;
  final ConfettiConfig confettiConfig;

  @override
  State<PoopCalendarScreen> createState() => _PoopCalendarScreenState();
}

class _PoopCalendarScreenState extends State<PoopCalendarScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _confettiController;
  late DateTime _visibleMonth;
  late DateTime _selectedDay;
  late Stream<List<PoopLog>> _visibleMonthLogs;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      vsync: this,
      duration: widget.confettiConfig.duration,
    );
    final DateTime today = DateTime.now();
    _visibleMonth = DateTime(today.year, today.month);
    _selectedDay = dateOnly(today);
    _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
      _selectedDay = _clampSelectedDayToVisibleMonth();
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = dateOnly(day);
      _visibleMonth = DateTime(day.year, day.month);
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  void _goToToday() {
    final DateTime today = DateTime.now();
    setState(() {
      _visibleMonth = DateTime(today.year, today.month);
      _selectedDay = dateOnly(today);
      _visibleMonthLogs = widget.repository.watchLogsForMonth(_visibleMonth);
    });
  }

  Future<void> _toggleSelectedDay(PoopLog? selectedLog) async {
    setState(() {
      _isSaving = true;
    });

    try {
      if (selectedLog == null) {
        await widget.repository.createLogForDay(_selectedDay);
        if (mounted && widget.confettiConfig.enabled) {
          unawaited(_confettiController.forward(from: 0));
        }
      } else {
        await widget.repository.deleteLog(selectedLog.id);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _confirmAndDeleteLog(PoopLog log) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove log?'),
          content: const Text('This will unlog the selected date.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !mounted) {
      return;
    }

    await _toggleSelectedDay(log);
  }

  DateTime _clampSelectedDayToVisibleMonth() {
    final int lastDay = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    return DateTime(
      _visibleMonth.year,
      _visibleMonth.month,
      _selectedDay.day.clamp(1, lastDay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        child: StreamBuilder<List<PoopLog>>(
          stream: _visibleMonthLogs,
          initialData: const <PoopLog>[],
          builder:
              (BuildContext context, AsyncSnapshot<List<PoopLog>> snapshot) {
                final List<PoopLog> logs = snapshot.data ?? const <PoopLog>[];
                final Set<DateTime> poopDays = logs
                    .map((PoopLog log) => dateOnly(log.occurredAt))
                    .toSet();
                final PoopLog? selectedLog = _logForDay(logs, _selectedDay);
                final bool selectedDayIsMarked = selectedLog != null;
                final bool selectedDayIsInFuture = isFutureDay(_selectedDay);

                return Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 118),
                      children: [
                        const AppHeader(),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                              CalendarSection(
                                visibleMonth: _visibleMonth,
                                selectedDay: _selectedDay,
                                poopDays: poopDays,
                                onPreviousMonth: _goToPreviousMonth,
                                onNextMonth: _goToNextMonth,
                                onTodayPressed: _goToToday,
                                onDaySelected: _selectDay,
                              ),
                              const SizedBox(height: 16),
                              SelectedDayPanel(
                                day: _selectedDay,
                                log: selectedLog,
                                isMarked: selectedDayIsMarked,
                                isFutureDate: selectedDayIsInFuture,
                                monthLogCount: logs.length,
                                showStreak: widget.featureFlags.streaks,
                                showLogButton:
                                    widget.featureFlags.selectedDayLogButton,
                                onToggle:
                                    _isSaving ||
                                        (selectedDayIsInFuture &&
                                            selectedLog == null)
                                    ? null
                                    : () => _toggleSelectedDay(selectedLog),
                                onRemoveLogPressed:
                                    _isSaving || selectedLog == null
                                    ? null
                                    : () => _confirmAndDeleteLog(selectedLog),
                              ),
                              OptionalFeatureSections(
                                featureFlags: widget.featureFlags,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PoopBottomNavigation(
                        isLogged: selectedDayIsMarked,
                        isFutureDate: selectedDayIsInFuture,
                        featureFlags: widget.featureFlags,
                        onLogPressed:
                            _isSaving ||
                                selectedDayIsMarked ||
                                selectedDayIsInFuture
                            ? null
                            : () => _toggleSelectedDay(null),
                      ),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _confettiController,
                          builder: (BuildContext context, Widget? child) {
                            if (_confettiController.isDismissed ||
                                _confettiController.isCompleted) {
                              return const SizedBox.shrink();
                            }

                            return CustomPaint(
                              key: const Key('log-confetti'),
                              painter: _ConfettiPainter(
                                progress: _confettiController.value,
                                config: widget.confettiConfig,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress, required this.config});

  final double progress;
  final ConfettiConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    if (config.colors.isEmpty) {
      return;
    }

    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double fade = (1 - progress).clamp(0.0, 1.0);
    final double eased = Curves.easeOutCubic.transform(progress);

    for (int i = 0; i < config.pieceCount; i += 1) {
      final double seed = i.toDouble();
      final double startX = ((seed * 47) % 100) / 100 * size.width;
      final double drift =
          math.sin(seed * 1.7) * config.maxHorizontalDrift * progress;
      final double fall =
          size.height *
          (config.fallStartFraction + config.fallDistanceFraction * eased);
      final double stagger = ((seed * 13) % 24) / 24;
      final double y =
          -config.topStartOffset - stagger * config.verticalStagger + fall;

      if (y > size.height || y < -config.topStartOffset - 44) {
        continue;
      }

      paint.color = config.colors[i % config.colors.length].withValues(
        alpha: fade,
      );
      canvas.save();
      canvas.translate(startX + drift, y);
      canvas.rotate(progress * math.pi * (2 + (i % 5)) + seed);

      final double width = config.minPieceWidth + (i % 3) * config.widthStep;
      final double height = config.minPieceHeight + (i % 4) * config.heightStep;
      final RRect piece = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: width, height: height),
        Radius.circular(config.cornerRadius),
      );
      canvas.drawRRect(piece, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.config != config;
  }
}

class OptionalFeatureSections extends StatelessWidget {
  const OptionalFeatureSections({required this.featureFlags, super.key});

  final FeatureFlags featureFlags;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (featureFlags.bristol) ...[
          const SizedBox(height: 16),
          const BristolSection(),
        ],
        if (featureFlags.mood) ...[
          const SizedBox(height: 12),
          const MoodSection(),
        ],
        if (featureFlags.hasHealthProgress) ...[
          const SizedBox(height: 12),
          _HealthProgressRow(featureFlags: featureFlags),
        ],
        if (featureFlags.notes) ...[
          const SizedBox(height: 12),
          const NotesCard(),
        ],
      ],
    );
  }
}

class _HealthProgressRow extends StatelessWidget {
  const _HealthProgressRow({required this.featureFlags});

  final FeatureFlags featureFlags;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      if (featureFlags.hydration)
        const Expanded(
          child: ProgressCard(
            asset: AppAssets.hydrationDrop,
            title: 'Hydration',
            value: '6 / 8 cups',
            progress: 0.75,
            color: Color(0xFF22A9A4),
          ),
        ),
      if (featureFlags.hydration && featureFlags.fiber)
        const SizedBox(width: 10),
      if (featureFlags.fiber)
        const Expanded(
          child: ProgressCard(
            asset: AppAssets.fiberLeaf,
            title: 'Fiber',
            value: '18 / 25 g',
            progress: 0.72,
            color: Color(0xFF3F8E2E),
          ),
        ),
    ];

    return Row(children: cards);
  }
}

PoopLog? _logForDay(List<PoopLog> logs, DateTime day) {
  for (final PoopLog log in logs) {
    if (isSameDay(log.occurredAt, day)) {
      return log;
    }
  }

  return null;
}
