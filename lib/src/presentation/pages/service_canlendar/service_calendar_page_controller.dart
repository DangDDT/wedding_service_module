import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/mock/dummy.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/widgets/add_day_off_bottom_sheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceCalendarPageController extends GetxController {
  final _selectedDate = DateTime.now().obs;
  final selectedDayOffInfos = StateDataVM<List<DayOffInfoModel>>(null).obs;
  final dayOffInMonth = RxList<DayOffInfoModel>().obs;

  @override
  void onInit() {
    _loadDayOffInMonth();
    super.onInit();
  }

  DateTime get selectedDateValue => _selectedDate.value;

  set selectedDate(DateTime date) {
    _selectedDate.value = date;
    loadDayOffInDay();
  }

  Future<void> _loadDayOffInMonth() async {
    //TODO: Load day off in month
  }

  Future<void> loadDayOffInDay() async {
    selectedDayOffInfos.loading();
    try {
      //TODO: Load day off in day
      await Future.delayed(const Duration(seconds: 1));
      selectedDayOffInfos.success(
        [
          DayOffInfoModel(
            id: '',
            reason: 'Bận việc gia đình',
            date: DateTime.now(),
            weddingService: Dummy.services.skip(2).take(1).first,
          ),
          DayOffInfoModel(
            id: '',
            reason: 'Thực hiện dịch vụ "Tổ chức tiệc cưới" cho khách hàng',
            date: DateTime.now(),
            weddingService: Dummy.services.skip(1).take(1).first,
          ),
        ],
      );
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
  }
}
