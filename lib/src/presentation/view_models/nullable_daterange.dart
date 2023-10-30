class NullableDateRange {
  const NullableDateRange({
    this.start,
    this.end,
  });

  final DateTime? start;
  final DateTime? end;
}

extension NullableDateRangeX on NullableDateRange {
  /// Whether both [start] and [end] are null.
  bool get isNull => start == null && end == null;

  /// Whether both [start] and [end] are not null.
  bool get isNotNull => !isNull;

  /// Whether [start] is null.
  bool get isStartNull => start == null;

  /// Whether [end] is null.
  bool get isEndNull => end == null;

  /// Gets the [Duration] between [start] and [end].
  ///
  /// Returns null if either [start] or [end] is null.
  Duration? get duration {
    if (start == null || end == null) {
      return null;
    }
    return end!.difference(start!);
  }
}
