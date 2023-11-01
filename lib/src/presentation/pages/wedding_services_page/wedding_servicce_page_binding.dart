import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';

class WeddingServicePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeddingServicesPageController>(
      () => WeddingServicesPageController(),
      tag: WeddingServicesPage.bindingTag,
    );
  }
}
