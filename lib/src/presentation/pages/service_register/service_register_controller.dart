import 'dart:math';

import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:wedding_service_module/core/utils/mixins/local_attachment_picker_mixin.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';

class ServiceRegisterPageController extends GetxController
    with GetSingleTickerProviderStateMixin, LocalAttachmentPickerMixin {
  final state = StateDataVM<bool>(false).obs;
  final category = Rx<StateDataVM<ServiceCategoryModel>>(
    StateDataVM<ServiceCategoryModel>(null),
  );

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
      //Load data from api (maybe)
      await Future.delayed(const Duration(seconds: 2));
      category.value = category.value.success(
        ServiceCategoryModel(
          id: '1',
          name: 'Xe Đưa Đón',
          code: 'DV1',
          description:
              'Cho thuê xe đám cưới cho cô dâu chú rể. Đảm bảo chất lượng, giá cả phải chăng.',
          commissionRate: 8,
          // image: 'https://picsum.photos/200/300',
        ),
      );
    } catch (e, stackTrace) {
      category.value = category.value.error(e.toString());
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        name: 'ServiceRegisterSheetController._loadUserServiceCategory',
      );
    }
  }

  // Future<void> addAttachment() async {
  //   try {
  // final source = await Get.bottomSheet<ImageSource?>(
  //   const ActionBottomSheet<ImageSource>(
  //     title: 'Thêm ảnh',
  //     subTitle: 'Chọn ảnh từ',
  //     items: [
  //       ActionBottomSheetItem(
  //         title: 'Thư viện',
  //         icon: Icon(Icons.photo_library),
  //         value: ImageSource.gallery,
  //       ),
  //       ActionBottomSheetItem(
  //         title: 'Máy ảnh',
  //         icon: Icon(Icons.camera_alt),
  //         value: ImageSource.camera,
  //       ),
  //     ],
  //   ),
  // );

  // final result = await CorePicker.showPickerMenu(
  //   submitButtonTitle: 'Chọn',
  // );

  // if (source == null) {
  //   return;
  // }

  // final image = await _pickImage(source);

  // if (image == null) {
  //   return;
  // }

  // attachment.value = image;
  // final file = File(image.path);
  // attachmentFile.value = file;
  //   } catch (e, stackTrace) {
  //     Logger.logCritical(
  //       e.toString(),
  //       stackTrace: stackTrace,
  //       name: 'ServiceRegisterSheetController.pickImage',
  //     );
  //   }
  // }

  // Future<XFile?> _pickImage(ImageSource imageSource) {
  //   final picker = ImagePicker();
  //   return picker.pickImage(source: imageSource);
  // }

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
