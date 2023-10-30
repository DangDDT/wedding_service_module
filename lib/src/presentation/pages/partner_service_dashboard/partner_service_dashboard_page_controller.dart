import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/enums/private/stats_time_range_type_enum.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';

class PartnerServiceDashboardPageController extends GetxController {
  //RevenueStats
  final dateRange = const NullableDateRange().obs;

  //WeekCalendarView
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    final date = StatsTimeRangeType.values.first.dateTimeRange;
    dateRange.value = NullableDateRange(
      start: date?.start,
      end: date?.end,
    );
    super.onInit();
  }
}
