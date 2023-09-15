import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/core.dart';
import '../../../shared/shared.dart';
import '../ads_service_controller.dart';

class AllAdsView extends GetView<AdsServiceController> {
  const AllAdsView({super.key});

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
              'MÙA NÀY CÓ GÌ ?',
              style: kTheme.textTheme.displaySmall!.copyWith(
                color: kTheme.colorScheme.onBackground,
              ),
            ),
            kGapH12,
            ExpandablePageView(
              controller: controller.allAdsPageController,
              physics: const NeverScrollableScrollPhysics(),
              animationDuration: const Duration(milliseconds: 1000),
              children: const [
                _FirstPageAds(),
                _SecondPageAds(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstPageAds extends GetView<AdsServiceController> {
  const _FirstPageAds();

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
                mainAxisCellCount: 3,
                child: FadeSlideTransition(
                  begin: const Offset(-0.5, 0.0),
                  duration: const Duration(milliseconds: 410),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ads_image_1_jpeg,
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
                mainAxisCellCount: 2,
                child: FadeSlideTransition(
                  begin: const Offset(0.5, 0.0),
                  duration: const Duration(milliseconds: 610),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ads_image_3_jpeg,
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
                mainAxisCellCount: 2,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ExtendedImage.asset(
                      Assets
                          .wedding_service_module$assets_images_ads_image_2_jpeg,
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
                mainAxisCellCount: 2,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  begin: const Offset(0.0, -0.2),
                  child: Text(
                    'Mùa thu chung nhà',
                    style: kTheme.textTheme.displaySmall!.copyWith(
                      color: kTheme.colorScheme.onBackground,
                      fontFamily: GoogleFonts.dancingScript().fontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            AnimationConfiguration.staggeredList(
              position: 4,
              child: StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 810),
                  begin: const Offset(1.0, 0.0),
                  child: GestureDetector(
                    onTap: () => controller.onChangePageAllAds(1),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kGapH32,
                          Text(
                            'Một chút tâm ý',
                            style: kTheme.textTheme.titleSmall!.copyWith(
                              color: kTheme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          kGapW4,
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: kTheme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _SecondPageAds extends GetView<AdsServiceController> {
  const _SecondPageAds();

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      duration: const Duration(milliseconds: 610),
      begin: const Offset(0.0, 0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: kTheme.colorScheme.primaryContainer.withOpacity(.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Mùa thu chung nhà',
                style: kTheme.textTheme.headlineLarge!.copyWith(
                  color: kTheme.colorScheme.onBackground,
                  fontFamily: GoogleFonts.dancingScript().fontFamily,
                ),
              ),
            ),
            kGapH12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🍂 Mùa Thu - Thời Điểm Lãng Mạn Cho Ngày Cưới! 🍂',
                  style: kTheme.textTheme.bodySmall!.copyWith(
                    color: kTheme.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kGapH16,
                Text(
                  'Mùa thu với khung cảnh tuyệt đẹp và không khí ấm áp là thời điểm hoàn hảo để kết hợp tình yêu của bạn thành một ngày cưới đáng nhớ.',
                  style: kTheme.textTheme.bodySmall!.copyWith(
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
                kGapH8,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '💍 Tiệc Cưới Đẹp Mắt:',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' Tận hưởng bữa tiệc đẳng cấp với thực đơn tinh tế và không gian trang trí đầy ấn tượng.',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                kGapH4,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '💐 Buổi Chụp Ảnh Lãng Mạn:',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' Chụp những khoảnh khắc tuyệt vời trong không gian tự nhiên đẹp như tranh vẽ của mùa thu.',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                kGapH4,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '🎵 Lễ Kết Hợp Âm Nhạc:',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' Tạo nên không gian lãng mạn với âm nhạc sống động thể hiện tình cảm của bạn.',
                        style: kTheme.textTheme.labelSmall!.copyWith(
                          color: kTheme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                kGapH8,
                Text(
                  '🍁 Đánh dấu ngày cưới của bạn trong không gian ấm áp và đầy màu sắc của mùa thu. Hãy để chúng tôi tạo nên ngày cưới hoàn hảo cho bạn!',
                  style: kTheme.textTheme.bodySmall!.copyWith(
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
                kGapH8,
                Text(
                  '#CướiMùaThu #NgàyCướiLãngMạn #DịchVụCưới',
                  style: kTheme.textTheme.bodySmall!.copyWith(
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.onChangePageAllAds(0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                          color: kTheme.colorScheme.primary,
                        ),
                        kGapW4,
                        Text(
                          'Trở về',
                          style: kTheme.textTheme.titleSmall!.copyWith(
                            color: kTheme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
