import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_calendar/service_calendar_page_controller.dart';

class ServiceCalendarPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceCalendarPageController>(
      () => ServiceCalendarPageController(),
    );
  }
}
