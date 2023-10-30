import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';

enum StatsTimeRangeType {
  /// The last 365 days
  last365Days,

  /// The last 30 days
  last30Days,

  /// The last 90 days
  last90Days,

  /// The last 7 days
  last7Days,

  /// All time
  allTime,

  /// Custom time range
  custom,
}

extension StatsTimeRangeTypeExtension on StatsTimeRangeType {
  /// Returns the string representation of the enum value.
  String get title {
    switch (this) {
      case StatsTimeRangeType.last7Days:
        return '1 Tuần';
      case StatsTimeRangeType.last30Days:
        return '1 Tháng';
      case StatsTimeRangeType.last90Days:
        return '1 Quý';
      case StatsTimeRangeType.last365Days:
        return '1 Năm';
      case StatsTimeRangeType.allTime:
        return 'Tất cả';
      case StatsTimeRangeType.custom:
        return 'Tùy chọn';
    }
  }

  /// Returns the [DateTimeRangeData] of the enum value.
  ///
  /// Returns `null` if the enum value is not [StatsTimeRangeType.custom].
  NullableDateRange? get dateTimeRange {
    final toDay = DateTime.now();
    switch (this) {
      case StatsTimeRangeType.last7Days:
        return NullableDateRange(
          start: toDay.subtract(const Duration(days: 7)),
          end: toDay,
        );
      case StatsTimeRangeType.last30Days:
        return NullableDateRange(
          start: toDay.subtract(const Duration(days: 30)),
          end: toDay,
        );
      case StatsTimeRangeType.last90Days:
        return NullableDateRange(
          start: toDay.subtract(const Duration(days: 90)),
          end: toDay,
        );
      case StatsTimeRangeType.last365Days:
        return NullableDateRange(
          start: toDay.subtract(const Duration(days: 365)),
          end: toDay,
        );
      case StatsTimeRangeType.allTime:
        return const NullableDateRange();
      case StatsTimeRangeType.custom:
        return null;
    }
  }
}
