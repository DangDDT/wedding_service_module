import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_service_module/src/domain/mock/dummy.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class AddDayOffController extends GetxController {
  final selectedWeddingService = Rxn<WeddingServiceModel>();
  final selectedDate = Rxn<DateTime>();
  final reason = RxString('');
  final addingState = Rx<LoadingState>(LoadingState.idle);
  //
  final userServices = StateDataVM<List<WeddingServiceModel>>([]).obs;

  AddDayOffController({
    WeddingServiceModel? weddingService,
    DateTime? date,
  });

  @override
  void onInit() {
    if (selectedWeddingService.value == null) {
      loadServices();
    }
    super.onInit();
  }

  Future<void> loadServices() async {
    try {
      userServices.loading();
      //TODO: call api
      await Future.delayed(const Duration(seconds: 1));
      userServices.success(Dummy.services.take(6).toList());
    } catch (e, s) {
      Logger.logCritical(e.toString(), stackTrace: s);
      userServices.error('Có lỗi khi lấy danh sách dịch vụ');
    }
  }

  Future<void> pickDayOff() async {
    final context = Get.context;
    if (context == null) return;
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 100),
    );

    if (result == null) return;

    selectedDate.value = result;
  }

  Future<void> addDayOff() async {
    addingState.value = LoadingState.loading;
    await Future.delayed(const Duration(seconds: 2));
    addingState.value = LoadingState.success;
  }
}
