import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/service_register_controller.dart';

class ServiceRegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceRegisterPageController>(
      () => ServiceRegisterPageController(),
    );
  }
}
