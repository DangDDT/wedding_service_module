import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/transactions_page/transactions_page_controller.dart';

class TransactionsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsPageController>(
      () => TransactionsPageController(),
    );
  }
}
