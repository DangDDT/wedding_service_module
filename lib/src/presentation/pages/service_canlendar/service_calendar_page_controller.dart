import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/core/utils/helpers/snack_bar_helper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_day_offs_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/widgets/add_day_off_bottom_sheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceCalendarPageController extends GetxController {
  ServiceCalendarPageController({this.currentService});

  /// The service that is being viewed
  ///
  /// If null, the view will be in the mode of showing all services
  final WeddingServiceModel? currentService;
  //View data
  final calendarKey = UniqueKey().obs;
  final viewingDateRange = const NullableDateRange().obs;
  final _partnerDayOffService = Get.find<IPartnerDayOffService>();
  final _selectedDate = DateTime.now().obs;
  final focusDate = DateTime.now().obs;
  final selectedDayOffInfos = StateDataVM<List<DayOffInfoModel>>(null).obs;
  final dayOffInMonth = RxList<DayOffInfoModel>();

  @override
  void onInit() {
    selectedDate = DateTime.now();

    final startOfMonth = DateTime(
      _selectedDate.value.year,
      _selectedDate.value.month,
      1,
    );
    final endOfMonth = DateTime(
      _selectedDate.value.year,
      _selectedDate.value.month + 1,
      0,
    );

    viewingDateRange.value = NullableDateRange(
      start: startOfMonth,
      end: endOfMonth,
    );

    super.onInit();
  }

  @override
  void onReady() {
    _loadDayOffInMonth();
    loadDayOffInDay();
    super.onReady();
  }

  DateTime get selectedDateValue => _selectedDate.value;

  void onFocusDateChanged(DateTime date) {
    focusDate.value = date;
    viewingDateRange.value = NullableDateRange(
      start: DateTime(date.year, date.month, 1),
      end: DateTime(date.year, date.month + 1, 0),
    );
    _loadDayOffInMonth();
  }

  set selectedDate(DateTime date) {
    _selectedDate.value = date;
    loadDayOffInDay();
  }

  Future<void> _loadDayOffInMonth() async {
    try {
      final data = await _partnerDayOffService.getPartnerDayOffs(
        GetDayOffParams(
          serviceId: currentService?.id,
          dateRange: viewingDateRange.value,
        ),
      );

      dayOffInMonth.call(data);
      calendarKey.value = UniqueKey();
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> loadDayOffInDay() async {
    selectedDayOffInfos.loading();
    try {
      final start = _selectedDate.value.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        isUtc: true,
      );
      final end = _selectedDate.value.copyWith(
        hour: 23,
        minute: 59,
        second: 55,
        isUtc: true,
      );
      final data = await _partnerDayOffService.getPartnerDayOffs(
        GetDayOffParams(
          serviceId: currentService?.id,
          dateRange: NullableDateRange(start: start, end: end),
        ),
      );

      selectedDayOffInfos.success(data);
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
      selectedDayOffInfos.error('Có lỗi xảy ra, vui lòng thử lại sau!');
    }
  }

  Future<void> addDayOffInfo() async {
    final newInfo = await Get.bottomSheet(
      AddDayOffBottomSheet(
        selectedDate: selectedDateValue,
        selectedService: currentService,
      ),
      isDismissible: true,
      isScrollControlled: true,
    );

    if (newInfo != null) {
      SnackBarHelper.show(message: 'Thêm ngày nghỉ thành công');
      _loadDayOffInMonth();
      loadDayOffInDay();
    }
  }

  Future<void> deleteDayOffInfo(DayOffInfoModel info) async {
    try {
      await _partnerDayOffService.deletePartnerDayOff(info.id);
      SnackBarHelper.show(message: 'Xóa ngày nghỉ thành công');
      _loadDayOffInMonth();
      loadDayOffInDay();
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
      SnackBarHelper.show(message: 'Có lỗi xảy ra, vui lòng thử lại sau!');
    }
  }
}
