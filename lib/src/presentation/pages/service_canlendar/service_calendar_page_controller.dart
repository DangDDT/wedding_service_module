import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/core/utils/helpers/snack_bar_helper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_day_offs_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/widgets/add_day_off_bottom_sheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';
import 'package:wss_repository/base/constants/default_value_mapper_constants.dart';
import 'package:wss_repository/wss_repository.dart';

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
  final ITaskRepository _taskRepository = Get.find<ITaskRepository>();
  final _selectedDate = DateTime.now().obs;
  final focusDate = DateTime.now().obs;
  final selectedDayOffInfos = StateDataVM<List<DayOffInfoModel>>(null).obs;
  final dayOffInMonth = RxList<DayOffInfoModel>();
  final dayOffByTaskInMonth = RxList<DayOffInfoModel>();

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
    loadDayOffInMonth();
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
    loadDayOffInMonth();
  }

  set selectedDate(DateTime date) {
    _selectedDate.value = date;
    loadDayOffInDay();
  }

  Future<void> loadDayOffInMonth() async {
    try {
      final data = await _partnerDayOffService.getPartnerDayOffs(
        GetDayOffParams(
          serviceId: currentService?.id,
          dateRange: viewingDateRange.value,
        ),
      );

      final dayOffByTaskData = await _taskRepository.getTasks(
        param: GetTaskParam(
          page: null,
          pageSize: null,
          sortKey: null,
          sortOrder: null,
          taskName: null,
          startDateFrom: viewingDateRange.value.start,
          startDateTo: viewingDateRange.value.end,
          status: ['EXPECTED', 'TO_DO', 'IN_PROGRESS'],
        ),
      );
      final dayOffByTaskInMonthData = dayOffByTaskData.data?.where((element) {
        return element.orderDetail?.startTime != null;
      }).map((e) {
        return DayOffInfoModel(
          id: e.id ?? DefaultValueConstants.string,
          date: e.orderDetail?.startTime ?? DefaultValueConstants.dateTime,
          reason:
              'Được ${e.createBy?.fullname} đặt dịch vụ ${e.orderDetail?.service?.name}',
          weddingService: WeddingServiceDayOffInfo(
            id: e.orderDetail?.service?.id ?? DefaultValueConstants.string,
            name: e.orderDetail?.service?.name ?? DefaultValueConstants.string,
            listImage: e.orderDetail?.service?.serviceImages?.map((e) {
                  return ImageModel(
                    id: Random().nextInt(1000).toString(),
                    imageUrl: e.imageUrl ?? DefaultValueConstants.string,
                  );
                }).toList() ??
                [],
          ),
        );
      }).toList();
      dayOffByTaskInMonth.call(dayOffByTaskInMonthData ?? []);
      dayOffInMonth.call(data);
      calendarKey.value = UniqueKey();
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> loadDayOffInDay() async {
    selectedDayOffInfos.loading();
    try {
      final start = _selectedDate.value.firstTimeOfDate();
      final end = _selectedDate.value.lastTimeOfDate();
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
        serviceExcepts: [
          ...selectedDayOffInfos.value.data?.map(
                (e) => ServiceExcept(
                  id: e.weddingService.id,
                  type: ServiceExceptType.dayOff,
                ),
              ) ??
              [],
          ...dayOffByTaskInMonth
              .where((e) => e.date.isSameDate(selectedDateValue))
              .map(
                (e) => ServiceExcept(
                  id: e.weddingService.id,
                  type: ServiceExceptType.dayOffByTask,
                ),
              ),
        ],
        selectedDate: selectedDateValue,
        selectedService: currentService,
      ),
      isDismissible: true,
      isScrollControlled: true,
    );

    if (newInfo != null) {
      SnackBarHelper.show(message: 'Thêm ngày nghỉ thành công');
      loadDayOffInMonth();
      loadDayOffInDay();
    }
  }

  Future<void> deleteDayOffInfo(DayOffInfoModel info) async {
    try {
      final isConfirm = await Get.dialog(
        AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn xóa ngày nghỉ này?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Xóa'),
            ),
          ],
        ),
      );
      if (isConfirm != true) return;
      await _partnerDayOffService.deletePartnerDayOff(info.id);
      SnackBarHelper.show(message: 'Xóa ngày nghỉ thành công');
      loadDayOffInMonth();
      loadDayOffInDay();
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
      SnackBarHelper.show(message: 'Có lỗi xảy ra, vui lòng thử lại sau!');
    }
  }
}
