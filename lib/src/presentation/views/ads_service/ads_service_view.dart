import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/views/ads_service/widgets/restaurant_ads_view.dart';

import '../../../../core/core.dart';
import '../../../domain/enums/private/service_category_enum.dart';
import 'ads_service_controller.dart';
import 'widgets/all_ads_view.dart';
import 'widgets/ao_dai_ads_view.dart';
import 'widgets/categories_selection.dart';
import 'widgets/make_up_ads_view.dart';
import 'widgets/vehicle_ads_view.dart';
import 'widgets/vest_ads_view.dart';
import 'widgets/wedding_dress_ads_view.dart';
import 'widgets/wedding_tray_ads_view.dart';

class AdsServiceView extends StatelessWidget {
  const AdsServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsServiceController>(
      init: AdsServiceController(),
      builder: (_) {
        return const Column(
          children: [
            CategoriesSelection(),
            kGapH12,
            AdsView(),
          ],
        );
      },
    );
  }
}

class AdsView extends GetView<AdsServiceController> {
  const AdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          switch (controller.selectedCategory.value.type) {
            case ServiceCategoryEnum.all:
              return const AllAdsView();
            case ServiceCategoryEnum.vayCuoi:
              return const WeddingDressAdsView();
            case ServiceCategoryEnum.aoDai:
              return const AoDaiAdsView();
            case ServiceCategoryEnum.vest:
              return const VestAdsView();
            case ServiceCategoryEnum.trangDiem:
              return const MakeupAdsView();
            case ServiceCategoryEnum.duaRuoc:
              return const VehicleAdsView();
            case ServiceCategoryEnum.nhaHang:
              return const RestaurantAdsView();
            case ServiceCategoryEnum.trapCuoi:
              return const WeddingTrayAdsView();
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
