import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page_controller.dart';

class ServiceDetailPageBindings implements Bindings {
  @override
  void dependencies() {
    final serviceId = Get.arguments['serviceId'];
    Get.lazyPut<ServiceDetailPageController>(
      () => ServiceDetailPageController(
        serviceId: serviceId!,
      ),
    );
  }
}
