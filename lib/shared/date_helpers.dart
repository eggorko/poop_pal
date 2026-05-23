DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

bool isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

List<DateTime> buildCalendarCells(DateTime visibleMonth) {
  final DateTime firstDay = DateTime(visibleMonth.year, visibleMonth.month);
  final int leadingDays = firstDay.weekday - DateTime.monday;
  final DateTime gridStart = firstDay.subtract(Duration(days: leadingDays));

  return <DateTime>[
    for (int index = 0; index < 42; index++)
      DateTime(gridStart.year, gridStart.month, gridStart.day + index),
  ];
}

String monthTitle(DateTime date) {
  return '${_months[date.month - 1]} ${date.year}';
}

String shortMonthTitle(DateTime date) {
  return '${_shortMonths[date.month - 1]} ${date.year}';
}

String weekdayShort(DateTime date) {
  return _weekdays[date.weekday - 1];
}

const List<String> _months = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> _shortMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

const List<String> _weekdays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
