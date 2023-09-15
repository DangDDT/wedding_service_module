import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/shared/shared.dart';

import '../../../../../core/core.dart';
import '../ads_service_controller.dart';

class WeddingTrayAdsView extends GetView<AdsServiceController> {
  const WeddingTrayAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: FadeSlideTransition(
        duration: const Duration(milliseconds: 410),
        begin: const Offset(0, 0.1),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MÂM QUẢ TRAO DUYÊN',
                  style: kTheme.textTheme.headlineMedium!.copyWith(
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Đặt ngay >',
                    style: kTheme.textTheme.bodyMedium!.copyWith(
                      color: kTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            kGapH24,
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
    return CarouselSlider(
      items: const [
        _Image(
          assetString:
              Assets.wedding_service_module$assets_images_trap_ads_image_1_jpeg,
        ),
        _Image(
          assetString:
              Assets.wedding_service_module$assets_images_trap_ads_image_2_jpeg,
        ),
        _Image(
          assetString:
              Assets.wedding_service_module$assets_images_trap_ads_image_3_jpeg,
        ),
        _Image(
          assetString:
              Assets.wedding_service_module$assets_images_trap_ads_image_4_jpeg,
        ),
      ],
      options: CarouselOptions(
        clipBehavior: Clip.none,
        aspectRatio: 16 / 9,
        viewportFraction: 0.85,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        autoPlayCurve: Curves.decelerate,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String assetString;
  const _Image({
    required this.assetString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: kTheme.colorScheme.onBackground.withOpacity(0.2),
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExtendedImage.asset(
          assetString,
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.color,
          color: kTheme.colorScheme.primary.withOpacity(0.3),
          border: Border.all(
            color: kTheme.colorScheme.primary.withOpacity(0.2),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
