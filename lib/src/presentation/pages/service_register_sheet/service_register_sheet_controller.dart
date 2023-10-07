import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/vif_bottom_sheet_layout.dart';

class ServiceRegisterSheetController extends GetxController {
  final state = StateDataVM<bool>(false).obs;
  final attachment = Rxn<XFile>(null);
  final attachmentFile = Rxn<File>(null);

  final WeddingServiceModel service;
  late final AnimationController slideUpAnimatedController;

  ServiceRegisterSheetController(this.service);

  @override
  void onInit() {
    super.onInit();
    slideUpAnimatedController = AnimationController(
      vsync: Navigator.of(Get.context!),
      duration: const Duration(milliseconds: 310),
    );

    slideUpAnimatedController.forward();
  }

  @override
  void onClose() {
    slideUpAnimatedController.reverse();
    slideUpAnimatedController.dispose();
    super.onClose();
  }

  Future<void> addAttachment() async {
    try {
      final source = await Get.bottomSheet<ImageSource?>(
        const ActionBottomSheet<ImageSource>(
          title: 'Thêm ảnh',
          subTitle: 'Chọn ảnh từ',
          items: [
            ActionBottomSheetItem(
              title: 'Thư viện',
              icon: Icon(Icons.photo_library),
              value: ImageSource.gallery,
            ),
            ActionBottomSheetItem(
              title: 'Máy ảnh',
              icon: Icon(Icons.camera_alt),
              value: ImageSource.camera,
            ),
          ],
        ),
      );

      if (source == null) {
        return;
      }

      final image = await _pickImage(source);

      if (image == null) {
        return;
      }

      attachment.value = image;
      final file = File(image.path);
      attachmentFile.value = file;
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        name: 'ServiceRegisterSheetController.pickImage',
      );
    }
  }

  Future<XFile?> _pickImage(ImageSource imageSource) {
    final picker = ImagePicker();
    return picker.pickImage(source: imageSource);
  }

  Future<void> register() async {
    try {
      state.value = state.value.loading(message: 'Đang đăng ký dịch vụ...');
      await Future.delayed(const Duration(seconds: 2));
      if (!_randomSuccess()) {
        throw Exception();
      }

      state.value = state.value.success(true);
    } catch (e) {
      state.value = state.value.error(
        'Đăng ký dịch vụ thất bại, vui lòng thử lại sau.',
      );
    }
  }

  ///Random success or failed with given rate, using radom algorithm
  bool _randomSuccess() {
    final random = Random();
    const failedRate = 0.7;

    return random.nextDouble() > failedRate;
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
