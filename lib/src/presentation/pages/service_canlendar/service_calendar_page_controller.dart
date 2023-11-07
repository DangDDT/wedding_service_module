import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/core/utils/helpers/snack_bar_helper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/requests/get_day_offs_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/widgets/add_day_off_bottom_sheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceCalendarPageController extends GetxController {
  final viewingDateRange = const NullableDateRange().obs;
  final _partnerDayOffService = Get.find<IPartnerDayOffService>();
  final _selectedDate = DateTime.now().obs;
  final selectedDayOffInfos = StateDataVM<List<DayOffInfoModel>>(null).obs;
  final dayOffInMonth = RxList<DayOffInfoModel>().obs;

  @override
  void onInit() {
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
    _loadDayOffInMonth();
    loadDayOffInDay();
    super.onInit();
  }

  DateTime get selectedDateValue => _selectedDate.value;

  Future<void> onViewingDateRangeChanged(NullableDateRange range) async {
    viewingDateRange.value = range;
    await _loadDayOffInMonth();
  }

  set selectedDate(DateTime date) {
    _selectedDate.value = date;
    loadDayOffInDay();
  }

  Future<void> _loadDayOffInMonth() async {
    try {
      final data = await _partnerDayOffService.getPartnerDayOffs(
        GetDayOffParams(
          dateRange: viewingDateRange.value,
        ),
      );

      dayOffInMonth.update((val) {
        val?.clear();
        val?.addAll(data);
      });
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> loadDayOffInDay() async {
    selectedDayOffInfos.loading();
    try {
      final data = await _partnerDayOffService.getPartnerDayOffs(
        GetDayOffParams(
          dateRange: NullableDateRange(
            start: _selectedDate.value.copyWith(hour: 0, minute: 0, second: 0),
            end: _selectedDate.value.copyWith(hour: 23, minute: 59, second: 59),
          ),
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
      const AddDayOffBottomSheet(),
      isDismissible: true,
      isScrollControlled: true,
    );

    if (newInfo != null) {
      SnackBarHelper.show(message: 'Thêm ngày nghỉ thành công');
      _loadDayOffInMonth();
      loadDayOffInDay();
    }
  }
}
