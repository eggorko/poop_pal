class FeatureFlags {
  const FeatureFlags({
    this.streaks = false,
    this.bristol = false,
    this.mood = false,
    this.hydration = false,
    this.fiber = false,
    this.notes = false,
    this.selectedDayLogButton = false,
    this.calendar = false,
    this.history = false,
    this.insights = false,
    this.profile = false,
  });

  const FeatureFlags.allEnabled()
    : streaks = true,
      bristol = true,
      mood = true,
      hydration = true,
      fiber = true,
      notes = true,
      selectedDayLogButton = true,
      calendar = true,
      history = true,
      insights = true,
      profile = true;

  final bool streaks;
  final bool bristol;
  final bool mood;
  final bool hydration;
  final bool fiber;
  final bool notes;
  final bool selectedDayLogButton;
  final bool calendar;
  final bool history;
  final bool insights;
  final bool profile;

  bool get hasHealthProgress => hydration || fiber;
}
