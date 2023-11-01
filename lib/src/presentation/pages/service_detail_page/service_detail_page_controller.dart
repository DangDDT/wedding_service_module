import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/mock/dummy.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceDetailPageController extends GetxController {
  ServiceDetailPageController({
    required this.serviceId,
  });

  final state = StateDataVM<WeddingServiceModel?>(null).obs;
  final imageViewHeight = (Get.height * 0.4).clamp(200.0, 350.0);
  final String serviceId;
  final currentImageIndex = 0.obs;
  final appBarOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  bool onScroll(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }

    if (notification is! ScrollUpdateNotification) {
      return false;
    }

    final lowestPoint = imageViewHeight * .6;

    if (notification.metrics.pixels == 0 ||
        notification.metrics.pixels <= lowestPoint) {
      appBarOpacity.value = 0;
      return false;
    }

    final pixels = notification.metrics.pixels - lowestPoint;
    if (pixels < 0 || pixels > 110) {
      return false;
    }

    final newOpacity = (pixels / 100).clamp(0.0, 1.0).toDouble();
    if (newOpacity == appBarOpacity.value) {
      return false;
    }

    appBarOpacity.value = newOpacity;
    return false;
  }

  Future<void> fetchData() async {
    state.value = state.value.loading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      final data = Dummy.services.firstWhereOrNull(
        (element) => element.id == serviceId,
      );
      state.value = state.value.success(data);
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        name: 'ServiceDetailPageController.fetchData',
      );
      state.value = state.value.error(e.toString());
    }
  }

  Future<void> register() async {
    final data = state.value.data;
    if (data == null) {
      return;
    }

    if (data.profitStatement != null) {
      return;
    }

    final result = await Get.toNamed(
      ModuleRouter.weddingServiceRegisterRoute,
    );

    if (result != null) {
      await fetchData();
    }
  }

  Future<void> reActive() async {
    //TODO: implement reActive
    throw UnimplementedError();
  }

  Future<void> deActive() async {
    //TODO: implement deActive
    throw UnimplementedError();
  }

  Future<void> contactUs() async {
    //TODO: implement contact us
    throw UnimplementedError();
  }

  Future<void> pushToSalesHistoryPage() async {
    //TODO: implement show sales history
    throw UnimplementedError();
  }

  void onImageIndexChanged(int index) {
    currentImageIndex.value = index;
  }
}
