import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/widgets/service_detail_page_view.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

class ServiceDetailPage extends GetView<ServiceDetailPageController> {
  const ServiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.state.value.status.isLoading &&
            controller.state.value.data == null) {
          return const LoadingWidget(isFullPage: true);
        }

        if (controller.state.value.status.isError) {
          return EmptyErrorHandler(
            title: 'Không tải được dữ liệu',
            description: 'Hiện tại không thể tải dữ liệu, vui lòng thử lại!',
            reloadCallback: controller.fetchData,
            isFullPage: true,
          );
        }

        return const ServiceDetailPageView();
      },
    );
  }
}
