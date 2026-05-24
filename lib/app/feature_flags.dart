class FeatureFlags {
  const FeatureFlags({
    this.streaks = false,
    this.bristol = false,
    this.mood = false,
    this.hydration = false,
    this.fiber = false,
    this.notes = false,
  });

  const FeatureFlags.allEnabled()
    : streaks = true,
      bristol = true,
      mood = true,
      hydration = true,
      fiber = true,
      notes = true;

  final bool streaks;
  final bool bristol;
  final bool mood;
  final bool hydration;
  final bool fiber;
  final bool notes;

  bool get hasHealthProgress => hydration || fiber;
}
