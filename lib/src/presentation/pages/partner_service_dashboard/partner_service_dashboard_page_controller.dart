import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/stats_time_range_type_enum.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class PartnerServiceDashboardPageController extends GetxController {
  final _weddingServiceService = Get.find<IWeddingServiceService>();
  //Recent added services
  final _maxRecentAddedServiceCount = 5;
  final recentAddedServices = StateDataVM<List<WeddingServiceModel>>(null).obs;

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
    fetchRecentAddedServices();
    super.onInit();
  }

  @override
  Future<void> refresh() => Future.wait([
        fetchRecentAddedServices(),
      ]);

  Future<void> fetchRecentAddedServices() async {
    try {
      recentAddedServices.loading();
      final services = await _weddingServiceService.getServices(
        GetWeddingServiceParam(
          status: WeddingServiceState.active,
          fromDate: null,
          toDate: null,
          categoryId: null,
          name: null,
          priceFrom: null,
          priceTo: null,
          pageIndex: 0,
          pageSize: _maxRecentAddedServiceCount,
          orderBy: 'CreateDate',
          orderType: 'DESC',
        ),
      );

      recentAddedServices.success(services);
    } catch (e, stackTrace) {
      Logger.logCritical(e.toString(), stackTrace: stackTrace);
      recentAddedServices.error('Có lỗi xảy ra, vui lòng thử lại sau');
    }
  }
}
