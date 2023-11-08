import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/module_configs.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/core/utils/helpers/snack_bar_helper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:wedding_service_module/core/utils/mixins/local_attachment_picker_mixin.dart';
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceRegisterPageController extends GetxController
    with GetSingleTickerProviderStateMixin, LocalAttachmentPickerMixin {
  final _moduleConfig = ModuleConfig.instance;
  final _weddingServiceService = Get.find<IWeddingServiceService>();
  final state = StateDataVM<bool>(false).obs;
  final category = Rx<StateDataVM<ServiceCategoryModel>>(
    StateDataVM<ServiceCategoryModel>(null),
  );

  final formKey = GlobalKey<FormState>();

  final serviceName = ''.obs;
  final serviceDescription = ''.obs;
  final servicePrice = ''.obs;
  final serviceUnit = ''.obs;

  ServiceRegisterPageController();

  @override
  void onInit() {
    super.onInit();
    _loadUserServiceCategory();
  }

  Future<void> _loadUserServiceCategory() async {
    category.value = category.value.loading();
    try {
      final id = await _moduleConfig.getMyCategoryIdCallback!();
      final userCategory = await _weddingServiceService.getCategory(id);
      category.success(userCategory);
    } catch (e, stackTrace) {
      category.value = category.value.error(e.toString());
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        name: 'ServiceRegisterSheetController._loadUserServiceCategory',
      );
    }
  }

  Future<void> register() async {
    try {
      if (category.value.isNullOrEmpty) {
        SnackBarHelper.show(
          message:
              'Hiện không lấy được danh mục dịch vụ. Vui lòng thử lại sau.',
          type: SnackBarType.error,
        );
        return;
      }
      if (state.value.status.isLoading) {
        return;
      }

      if (!state.value.isError) {
        if (formKey.currentState?.validate() == false) {
          return;
        }
      }

      state.value = state.value.loading(message: 'Đang đăng ký dịch vụ...');

      if (!attachmentPicker.isAllUploaded) {
        state.value = state.value.loading(message: 'Đang tải ảnh lên...');
        await attachmentPicker.uploadAll();
      }
      state.value = state.value.loading(message: 'Đang gửi yêu cầu...');
      final images = attachments
          .map(
            (e) => e.networkPath,
          )
          .map((e) => ImageModel(id: -1, imageUrl: e!))
          .toList();

      await _weddingServiceService.registerService(
        WeddingServiceModel.onRegister(
          name: serviceName.value,
          description: serviceDescription.value,
          unit: serviceUnit.value,
          price: double.parse(servicePrice.value),
          category: category.value.data ?? ServiceCategoryModel.empty(),
          images: images,
        ),
      );

      state.value = state.value.success(true);
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        name: 'ServiceRegisterSheetController.register',
      );
      state.value = state.value.error(
        'Đăng ký dịch vụ thất bại, vui lòng thử lại sau.',
      );
    }
  }

  void handlePopData() {
    if (state.value.status.isLoading) {
      return;
    }
    final data = state.value.data;
    if (data == null || !data) {
      Get.back();
      return;
    }

    if (data) {
      Get.back(result: true);
    }
  }
}
