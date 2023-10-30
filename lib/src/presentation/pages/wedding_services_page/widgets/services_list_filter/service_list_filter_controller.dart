import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/view_models/services_list_filter_data.dart';

class ServicesListFilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final kMinRevenue = 0.0;
  final kMaxRevenue = 100000000.0;
  final kRevenueRangeDivisions = 100000;

  late final AnimationController slideUpAnimatedController;
  late final Rx<ServicesListFilterData> filterData;

  @override
  void onInit() {
    slideUpAnimatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 210),
    )..forward();
    super.onInit();
  }

  void initFilter(ServicesListFilterData? initialData) {
    filterData = Rx(
      initialData ?? const ServicesListFilterData(),
    );
  }

  Future<void> pickRegisterStartDate() async {
    final context = Get.context;
    if (context == null) return;

    final now = DateTime.now();
    final initialDate = filterData.value.dateRange?.start ?? now;
    final lastDate = filterData.value.dateRange?.end ?? DateTime(2100);

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: lastDate,
    );

    if (date == null) return;

    final newDateRange = DateTimeRange(
      start: date,
      end: filterData.value.dateRange?.end ?? now,
    );

    filterData.value = filterData.value.copyWith(
      dateRange: () => newDateRange,
    );
  }

  Future<void> pickRegisterEndDate() async {
    final context = Get.context;
    if (context == null) return;

    final now = DateTime.now();
    final initialDate = filterData.value.dateRange?.end ?? now;
    final firstDate = filterData.value.dateRange?.start ?? DateTime(1900);

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    filterData.value = filterData.value.copyWith(
      dateRange: () => DateTimeRange(
        start: filterData.value.dateRange?.start ?? now,
        end: date,
      ),
    );
  }

  void onRevenueRangeChanged(RangeValues revenueRange) {
    filterData.value = filterData.value.copyWith(revenueRange: revenueRange);
  }

  Future<void> back({bool applyChanges = false}) async {
    print('BACK');
    await slideUpAnimatedController.reverse();
    Get.back(result: applyChanges ? filterData.value : null);
  }

  void onClear() {
    filterData.value = const ServicesListFilterData();
  }
}
