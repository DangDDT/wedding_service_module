import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/presentation/pages/requesting_services/requesting_service_page.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';

class RequestingServicePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeddingServicesPageController>(
      () => WeddingServicesPageController(viewWeddingServiceStates: [
        WeddingServiceState.registering,
        WeddingServiceState.rejected,
      ]),
      tag: RequestingServicePage.bindingTag,
    );
  }
}
