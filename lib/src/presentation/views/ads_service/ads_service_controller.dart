import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../../../domain/enums/private/service_category_enum.dart';
import '../../../domain/models/service_category_model.dart';
import '../../global/module_controller.dart';

class AdsServiceController extends GetxController {
  ///Controllers
  final ModuleController moduleController = Get.find<ModuleController>();

  final List<ServiceCategoryEnum> allowAppearCategories = [
    ServiceCategoryEnum.vayCuoi,
    ServiceCategoryEnum.aoDai,
    ServiceCategoryEnum.vest,
    ServiceCategoryEnum.trangDiem,
    ServiceCategoryEnum.duaRuoc,
    ServiceCategoryEnum.nhaHang,
    ServiceCategoryEnum.trapCuoi,
  ];

  ///All ads page controller
  final PageController allAdsPageController = PageController(
    initialPage: 0,
  );

  ///Áo dài ads page controller
  final PageController aoDaiAdsPageController = PageController(
    initialPage: 0,
  );

  final int aoDaiAdsPageCount = 3;
  final RxInt aoDaiAdsCurrentPage = 0.obs;
  final List<String> aoDaiAdsTitles = [
    'Áo dài truyền thống',
    'Việt phục ngày cưới',
    'Áo dài cách tân'
  ];

  final Rx<ServiceCategoryModel> selectedCategory =
      ServiceCategoryModel.all().obs;

  @override
  void onInit() {
    if (moduleController.serviceCategories.isInitial) {
      moduleController.loadServiceCategories();
    }
    super.onInit();
  }

  Future<void> onTapServiceCategorySelection(ServiceCategoryModel e) async {
    if (e.type == ServiceCategoryEnum.more) {
      Get.toNamed(RouteConstants.categoriesServiceRoute);
      return;
    }
    selectedCategory.value = e;
    aoDaiAdsCurrentPage.value = 0;
  }

  Future<void> onChangePageAllAds(int index) async {
    allAdsPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> onNextPageAoDaiAds() async {
    aoDaiAdsCurrentPage.value++;
    aoDaiAdsPageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  Future<void> onPreviousPageAoDaiAds() async {
    aoDaiAdsCurrentPage.value--;
    aoDaiAdsPageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }
}
