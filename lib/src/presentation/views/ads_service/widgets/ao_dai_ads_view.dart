import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../../../shared/shared.dart';
import '../ads_service_controller.dart';

class AoDaiAdsView extends GetView<AdsServiceController> {
  const AoDaiAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AnimationLimiter(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.aoDaiAdsCurrentPage.value > 0)
                    IconButton(
                      onPressed: controller.onPreviousPageAoDaiAds,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    )
                  else ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.bubble_chart,
                        size: 18,
                      ),
                    ),
                  ],
                  AnimatedSwitcher(
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, -0.25),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    duration: const Duration(milliseconds: 210),
                    child: FittedBox(
                      key: ValueKey(controller.aoDaiAdsCurrentPage.value),
                      child: Text(
                        controller.aoDaiAdsTitles[
                                controller.aoDaiAdsCurrentPage.value]
                            .toUpperCase(),
                        style: kTheme.textTheme.headlineSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  if (controller.aoDaiAdsCurrentPage.value <
                      controller.aoDaiAdsPageCount - 1)
                    IconButton(
                      onPressed: controller.onNextPageAoDaiAds,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    )
                  else ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.bubble_chart,
                        size: 18,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            kGapH12,
            ExpandablePageView(
              controller: controller.aoDaiAdsPageController,
              onPageChanged: (index) {
                controller.aoDaiAdsCurrentPage.value = index;
              },
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: _FirstView(),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: _SecondView(),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: _ThirdView(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstView extends GetView<AdsServiceController> {
  const _FirstView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 10,
          children: [
            AnimationConfiguration.staggeredList(
              position: 0,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.5,
                child: FadeSlideTransition(
                  begin: const Offset(-0.5, 0.0),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ao_dai_ads_image_3_jpeg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 1,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.8,
                child: FadeSlideTransition(
                  begin: const Offset(0.5, 0.0),
                  duration: const Duration(milliseconds: 610),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ao_dai_ads_image_1_jpeg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 2,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.5,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ao_dai_ads_image_2_jpeg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 3,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.2,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  begin: const Offset(-0.2, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedImage.asset(
                          Assets
                              .wedding_service_module$assets_images_ao_dai_ads_image_4_jpeg,
                        ).image,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xem thêm',
                          style: kTheme.textTheme.headlineMedium!.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                            shadows: [
                              BoxShadow(
                                color: kTheme.colorScheme.onPrimary
                                    .withOpacity(0.2),
                                blurRadius: 40,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        kGapW8,
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SecondView extends GetView<AdsServiceController> {
  const _SecondView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 10,
          children: [
            AnimationConfiguration.staggeredList(
              position: 0,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.8,
                child: FadeSlideTransition(
                  begin: const Offset(-0.5, 0.0),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_viet_phuc_ads_image_1_jpeg,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.color,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 1,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.8,
                child: FadeSlideTransition(
                  begin: const Offset(0.5, 0.0),
                  duration: const Duration(milliseconds: 610),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_viet_phuc_ads_image_2_jpeg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 3,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  begin: const Offset(-0.2, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedImage.asset(
                          Assets
                              .wedding_service_module$assets_images_viet_phuc_ads_image_3_jpeg,
                        ).image,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xem thêm',
                          style: kTheme.textTheme.headlineMedium!.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                            shadows: [
                              BoxShadow(
                                color: kTheme.colorScheme.onPrimary
                                    .withOpacity(0.2),
                                blurRadius: 40,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        kGapW8,
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ThirdView extends GetView<AdsServiceController> {
  const _ThirdView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 10,
          children: [
            AnimationConfiguration.staggeredList(
              position: 0,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.8,
                child: FadeSlideTransition(
                  begin: const Offset(-0.5, 0.0),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ao_dai_ct_ads_image_2_jpeg,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.color,
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 1,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 5,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  begin: const Offset(-0.2, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedImage.asset(
                          Assets
                              .wedding_service_module$assets_images_ao_dai_ct_ads_image_1_png,
                        ).image,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.black54,
                          BlendMode.darken,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xem thêm',
                          style: kTheme.textTheme.headlineMedium!.copyWith(
                            color: kTheme.colorScheme.onPrimary,
                            shadows: [
                              BoxShadow(
                                color: kTheme.colorScheme.onPrimary
                                    .withOpacity(0.2),
                                blurRadius: 40,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        kGapW8,
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 2,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.2,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ao_dai_ct_ads_image_3_jpeg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
