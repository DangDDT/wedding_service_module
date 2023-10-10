// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ServicesListFilterData {
  const ServicesListFilterData({
    this.dateRange,
    this.revenueRange = const RangeValues(0, 100000000),
  });

  /// [dateRange] is a range of date when service registered
  final DateTimeRange? dateRange;

  /// [revenueRange] is a range of revenue in million VND
  final RangeValues revenueRange;

  int get count {
    var count = 0;
    if (dateRange != null) {
      count++;
    }
    if (revenueRange.start != 0 || revenueRange.end != 10000000000) {
      count++;
    }
    return count;
  }

  ServicesListFilterData copyWith({
    ValueGetter<DateTimeRange?>? dateRange,
    RangeValues? revenueRange,
  }) {
    return ServicesListFilterData(
      dateRange: dateRange != null ? dateRange() : this.dateRange,
      revenueRange: revenueRange ?? this.revenueRange,
    );
  }
}
