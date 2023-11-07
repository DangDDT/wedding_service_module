import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/service_grid_item_widget.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

class RecentAddedServiceSection
    extends GetView<PartnerServiceDashboardPageController> {
  const RecentAddedServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text('Dịch vụ', style: kTextTheme.titleLarge)),
            kGapW12,
            TextButton(
              onPressed: () => Get.toNamed(ModuleRouter.weddingServicesRoute),
              child: const Text('Quản lý dịch vụ'),
            ),
          ],
        ),
        kGapH12,
        const _ListRecentAddedServices(),
      ],
    );
  }
}

class _ListRecentAddedServices
    extends GetView<PartnerServiceDashboardPageController> {
  const _ListRecentAddedServices();

  void _onServiceTap(WeddingServiceModel service) {
    Get.toNamed(ModuleRouter.weddingServiceDetailRoute, arguments: {
      'serviceId': service.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 250, minHeight: 120),
      child: Obx(() {
        if ((controller.recentAddedServices.isInitial ||
                controller.recentAddedServices.isLoading) &&
            !controller.recentAddedServices.hasData) {
          return const Center(
              child: LoadingWidget(message: 'Đang tải dữ liệu'));
        }

        if (controller.recentAddedServices.hasError) {
          return EmptyErrorHandler(
            title: 'Có lỗi xảy ra',
            description: controller.recentAddedServices.value.message,
          );
        }

        if (controller.recentAddedServices.isNullOrEmpty) {
          return const EmptyErrorHandler(title: 'Không có dữ liệu');
        }

        return ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.recentAddedServices.value.data?.length ?? 0,
          separatorBuilder: (_, __) => kGapW12,
          itemBuilder: _itemBuilder,
        );
      }),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final service = controller.recentAddedServices.value.data![index];
    return AspectRatio(
      aspectRatio: 0.75,
      child: ServiceGridItemWidget(
        service: service,
        onTap: () => _onServiceTap(service),
      ),
    );
  }
}
