class PoopLog {
  const PoopLog({
    required this.id,
    required this.occurredAt,
    required this.createdAt,
    required this.updatedAt,
    this.bristolType,
    this.mood,
    this.notes,
    this.hydrationCups,
    this.fiberGrams,
  });

  final int id;
  final DateTime occurredAt;
  final int? bristolType;
  final String? mood;
  final String? notes;
  final int? hydrationCups;
  final int? fiberGrams;
  final DateTime createdAt;
  final DateTime updatedAt;

  PoopLog copyWith({
    int? id,
    DateTime? occurredAt,
    Object? bristolType = _notSet,
    Object? mood = _notSet,
    Object? notes = _notSet,
    Object? hydrationCups = _notSet,
    Object? fiberGrams = _notSet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PoopLog(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      bristolType: bristolType == _notSet
          ? this.bristolType
          : bristolType as int?,
      mood: mood == _notSet ? this.mood : mood as String?,
      notes: notes == _notSet ? this.notes : notes as String?,
      hydrationCups: hydrationCups == _notSet
          ? this.hydrationCups
          : hydrationCups as int?,
      fiberGrams: fiberGrams == _notSet ? this.fiberGrams : fiberGrams as int?,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

const Object _notSet = Object();
