import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/core/utils/helpers/snack_bar_helper.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';

class SuspendServiceBottomSheetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _weddingServiceService = Get.find<IWeddingServiceService>();
  late AnimationController slideUpAnimatedController;
  late TextEditingController reasonController;

  final isActive = false.obs;
  final String serviceId;
  final loadingState = LoadingState.initial.obs;

  SuspendServiceBottomSheetController(this.serviceId);

  @override
  void onInit() {
    reasonController = TextEditingController()
      ..addListener(() {
        isActive.value = reasonController.text.isNotEmpty &&
            reasonController.text.length >= 10;
      });
    slideUpAnimatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 210),
    )..drive(CurveTween(curve: Curves.linear));

    slideUpAnimatedController.forward();

    super.onInit();
  }

  @override
  void onClose() {
    slideUpAnimatedController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  void onBack({
    bool? isSuccess,
  }) {
    slideUpAnimatedController.reverse().then((_) => Get.back(
          result: isSuccess,
        ));
  }

  Future<void> suspendService() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      loadingState.value = LoadingState.loading;
      await _weddingServiceService.suspendService(
        serviceId,
        reasonController.text,
      );
      loadingState.value = LoadingState.success;
      onBack(isSuccess: true);
    } catch (error, exception) {
      loadingState.value = LoadingState.error;
      SnackBarHelper.show(
        message: 'Có lỗi xảy ra, vui lòng thử lại',
        type: SnackBarType.error,
      );
      Logger.logCritical(
        error.toString(),
        stackTrace: exception,
        name: 'ServiceDetailPageController.deActive',
      );
    }
  }
}
