import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../../../shared/shared.dart';
import '../ads_service_controller.dart';

class MakeupAdsView extends GetView<AdsServiceController> {
  const MakeupAdsView({super.key});

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
            Text(
              'TÔ ĐIỂM HẠNH PHÚC',
              style: kTheme.textTheme.headlineMedium!.copyWith(
                color: kTheme.colorScheme.onBackground,
              ),
            ),
            kGapH12,
            const _MainView(),
          ],
        ),
      ),
    );
  }
}

class _MainView extends GetView<AdsServiceController> {
  const _MainView();

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
                  begin: const Offset(0.0, -0.2),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_trang_diem_ads_image_1_jpeg,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.color,
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
                  begin: const Offset(0.0, 0.2),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_trang_diem_ads_image_2_jpeg,
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
                mainAxisCellCount: 2.8,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 610),
                  begin: const Offset(0.0, 0.2),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedImage.asset(
                          Assets
                              .wedding_service_module$assets_images_trang_diem_ads_image_4_jpeg,
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
              position: 3,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2.2,
                child: FadeSlideTransition(
                  begin: const Offset(0.0, 0.2),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_trang_diem_ads_image_3_jpeg,
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
