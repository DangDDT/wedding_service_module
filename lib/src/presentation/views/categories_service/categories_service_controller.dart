import 'package:get/get.dart';
import 'package:wedding_service_module/core/core.dart';
import 'package:wedding_service_module/src/domain/enums/private/service_category_enum.dart';
import 'package:wedding_service_module/src/presentation/global/module_controller.dart';

class CategoriesServiceController extends GetxController {
  ///Controllers
  final ModuleController moduleController = Get.find<ModuleController>();

  @override
  void onInit() {
    if (moduleController.serviceCategories.isInitial) {
      moduleController.loadServiceCategories();
    }
    super.onInit();
  }

  String getImage(ServiceCategoryEnum type) {
    switch (type) {
      case ServiceCategoryEnum.vayCuoi:
        return Assets
            .wedding_service_module$assets_images_dress_ads_image_3_jpeg;
      case ServiceCategoryEnum.aoDai:
        return Assets
            .wedding_service_module$assets_images_ao_dai_ads_image_4_jpeg;
      case ServiceCategoryEnum.vest:
        return Assets
            .wedding_service_module$assets_images_vest_ads_image_2_jpeg;
      case ServiceCategoryEnum.trangDiem:
        return Assets
            .wedding_service_module$assets_images_trang_diem_ads_image_4_jpeg;
      case ServiceCategoryEnum.duaRuoc:
        return Assets.wedding_service_module$assets_images_car_ads_image_3_jpeg;
      case ServiceCategoryEnum.nhaHang:
        return Assets
            .wedding_service_module$assets_images_restaurant_ads_image_2_jpeg;
      case ServiceCategoryEnum.trapCuoi:
        return Assets
            .wedding_service_module$assets_images_trap_ads_image_2_jpeg;
      case ServiceCategoryEnum.mc:
        return Assets.wedding_service_module$assets_images_mc_ads_image_1_jpeg;
      default:
        return '';
    }
  }
}
