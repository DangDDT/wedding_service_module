import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';

class PartnerServiceDashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnerServiceDashboardPageController>(
      () => PartnerServiceDashboardPageController(),
    );
  }
}
