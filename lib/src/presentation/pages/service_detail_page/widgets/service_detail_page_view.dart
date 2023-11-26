import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_browser/photo_browser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/arguments/service_calendar_args.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/widgets/service_bussiness_situation_view.dart';
import 'package:wedding_service_module/src/presentation/widgets/page_count_widget.dart';

class ServiceDetailPageView extends GetView<ServiceDetailPageController> {
  const ServiceDetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(builder: (_) {
      return Scaffold(
        body: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: controller.onScroll,
              child: RefreshIndicator.adaptive(
                onRefresh: controller.fetchData,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: context.mediaQueryPadding.bottom + 24,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ServiceImages(),
                      kGapH24,
                      _ServiceInfos(),
                      Divider(height: 32),
                      _PriceAndRevenue(),
                      Divider(height: 32),
                      ServiceBusinessSituationView(),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _AppBar(),
            ),
          ],
        ),
      );
    });
  }
}

class _AppBar extends GetView<ServiceDetailPageController> {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        leading: UnconstrainedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(
                (1 - controller.appBarOpacity.value).clamp(0, 1).toDouble(),
              ),
            ),
            child: BackButton(
              color: kTheme.colorScheme.primary,
            ),
          ),
        ),
        actions: [
          if (controller.state.value.data?.state.isActive == true)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(
                  (1 - controller.appBarOpacity.value).clamp(0, 1).toDouble(),
                ),
              ),
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                tooltip: 'Lịch bận',
                onPressed: () => Get.toNamed(
                  ModuleRouter.weddingServiceCalendarRoute,
                  arguments: ServiceCalendarArgs(
                    service: controller.state.value.data!,
                  ),
                ),
                icon: Icon(
                  Icons.calendar_month,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
        ],
        scrolledUnderElevation: 0,
        elevation: 0,
        foregroundColor: controller.appBarOpacity.value > 0.5
            ? kTheme.colorScheme.onBackground
            : Colors.white,
        title: controller.appBarOpacity.value > 0.5
            ? Text(
                controller.state.value.data?.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        backgroundColor: kTheme.scaffoldBackgroundColor.withOpacity(
          controller.appBarOpacity.value,
        ),
      ),
    );
  }
}

class _ServiceImages extends GetView<ServiceDetailPageController> {
  const _ServiceImages();

  void viewImage(int index) {
    final images = controller.state.value.data?.images;
    if (images == null) {
      return;
    }
    //TODO: Handle this case, extract to a new class. Add close, open/download.
    PhotoBrowser photoBrowser = PhotoBrowser(
      itemCount: images.length,
      initIndex: index,
      controller: PhotoBrowserController(),
      allowTapToPop: false,
      allowSwipeDownToPop: false,
      allowPullDownToPop: true,
      imageUrlBuilder: (int index) {
        return images[index].imageUrl;
      },
      loadFailedChild: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );

    photoBrowser.push(Get.context!).then((value) {
      print('PhotoBrowser closed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: controller.imageViewHeight,
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.state.value.data!.images.length,
              onPageChanged: controller.onImageIndexChanged,
              itemBuilder: (context, index) {
                final image = controller.state.value.data!.images[index];
                return GestureDetector(
                  onTap: () => viewImage(index),
                  child: ExtendedImage.network(image.imageUrl,
                      fit: BoxFit.cover,
                      loadStateChanged: (state) =>
                          state.extendedImageLoadState == LoadState.failed
                              ? const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                )
                              : null),
                );
              },
            ),
            Positioned(
              bottom: 12,
              right: 8,
              child: Obx(
                () => PageCountWidget(
                  count: controller.state.value.data!.images.length,
                  currentIndex: controller.currentImageIndex.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceInfos extends GetView<ServiceDetailPageController> {
  const _ServiceInfos();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.state.value.data!.name,
              style: kTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            kGapH12,
            Text(
              controller.state.value.data!.description,
              style: TextStyle(
                color: kTheme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceAndRevenue extends GetView<ServiceDetailPageController> {
  const _PriceAndRevenue();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final state = controller.state.value.data;
        if (state == null) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Giá trị dịch vụ trên mỗi sản phẩm',
                style: kTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              kGapH12,
              _buildServiceInfoItem(
                'Giá',
                '${state.price.toVietNamCurrency()} /${state.unit}',
              ),
              kGapH4,
              _buildServiceInfoItem(
                'Tỉ lệ chiết khấu:',
                state.commissionRate == null
                    ? 'Chưa cập nhật'
                    : '${((state.commissionRate ?? 0)).toStringAsFixed(2)}%',
              ),
              kGapH4,
              _buildServiceInfoItem(
                'Doanh thu thực tế:',
                state.actualRevenue == null
                    ? 'Chưa cập nhật'
                    : state.actualRevenue!.toVietNamCurrency(),
              ),
              kGapH12,
              Text(
                '* Doanh thu thực tế được tính dựa trên tỉ lệ chiết khấu và giá bán ra.',
                style: kTextTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: kTheme.hintColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceInfoItem(String title, String content) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 140),
          child: Text(
            title,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
        ),
        Text(
          content,
          style: kTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: kTheme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
