import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/widgets/add_day_off_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/selection_button.dart';

enum ServiceExceptType {
  dayOff,
  dayOffByTask;

  String toReason() {
    switch (this) {
      case ServiceExceptType.dayOff:
        return 'Đã được tạo ngày nghỉ';
      case ServiceExceptType.dayOffByTask:
        return 'Đã được đặt dịch vụ';
    }
  }
}

class ServiceExcept {
  final String id;
  final ServiceExceptType type;

  ServiceExcept({
    required this.id,
    required this.type,
  });
}

class AddDayOffBottomSheet extends StatelessWidget {
  const AddDayOffBottomSheet({
    super.key,
    required this.serviceExcepts,
    this.selectedService,
    this.selectedDate,
  });
  final List<ServiceExcept> serviceExcepts;
  final WeddingServiceModel? selectedService;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDayOffController>(
      init: AddDayOffController(
        serviceExcept: serviceExcepts,
        weddingService: selectedService,
        date: selectedDate,
      ),
      builder: (controller) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: KeyboardDismisser(
          child: SafeArea(
            top: true,
            left: false,
            right: false,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kTheme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () {
                      return AnimatedSize(
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const _Header(),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 310),
                              switchInCurve: Curves.easeIn,
                              child: controller.selectedWeddingService.value ==
                                      null
                                  ? const _SelectServiceView()
                                  : const _AddDayOffForm(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends GetView<AddDayOffController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (controller.selectedWeddingService.value == null ||
                      !controller.canPickService.value)
                  ? const SizedBox.shrink()
                  : TextButton.icon(
                      onPressed: () =>
                          controller.selectedWeddingService.value = null,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      label: const Text('Dịch vụ'),
                    ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Text(
            'Thêm ngày nghỉ',
            textAlign: TextAlign.center,
            style: kTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: TextButton(
            onPressed: Get.back,
            child: const Text('Hủy'),
          ),
        ),
      ],
    );
  }
}

class _SelectServiceView extends GetView<AddDayOffController> {
  const _SelectServiceView();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 170,
        maxHeight: 400,
      ),
      child: PagedListView<int, WeddingServiceModel>.separated(
        pagingController: controller.pagingController,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const Divider(
          indent: 12,
          endIndent: 12,
          thickness: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) => EmptyErrorHandler(
            title: 'Không có dịch vụ nào',
            reloadCallback: controller.pagingController.refresh,
          ),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          firstPageErrorIndicatorBuilder: (context) => EmptyErrorHandler(
            title: 'Không thể tải dữ liệu',
            reloadCallback: controller.pagingController.refresh,
          ),
          firstPageProgressIndicatorBuilder: (context) => const LoadingWidget(
            axis: Axis.horizontal,
          ),
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }

  Widget _itemBuilder(
      BuildContext context, WeddingServiceModel service, int index) {
    final isEnabled =
        !controller.serviceExcept.map((e) => e.id).contains(service.id);
    final child = ListTile(
      onTap: isEnabled
          ? () => controller.selectedWeddingService.value = service
          : null,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(service.coverImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(service.name),
      subtitle: Text(service.description),
      trailing: isEnabled
          ? const Icon(Icons.arrow_forward_ios_rounded)
          : const SizedBox.shrink(),
    );
    if (isEnabled) {
      return child;
    }
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Transform.rotate(
              angle: -.2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  controller.serviceExcept
                      .firstWhere((e) => e.id == service.id)
                      .type
                      .toReason(),
                  style: kTheme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddDayOffForm extends GetView<AddDayOffController> {
  const _AddDayOffForm();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.addingState.value.isLoading
                ? const Center(
                    child: LoadingWidget(
                    message: 'Đang thêm ngày nghỉ...',
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dịch vụ',
                        style: kTheme.textTheme.titleSmall?.copyWith(
                          color: kTheme.hintColor,
                        ),
                      ),
                      kGapH4,
                      Text(
                        '${controller.selectedWeddingService.value?.name}',
                        style: kTheme.textTheme.titleMedium,
                      ),
                      kGapH12,
                      Text(
                        'Ngày nghỉ',
                        style: kTheme.textTheme.titleSmall?.copyWith(
                          color: kTheme.hintColor,
                        ),
                      ),
                      SelectionButton(
                        content: controller.selectedDate.value?.toReadable() ??
                            'Chọn ngày nghỉ',
                        onPressed: controller.pickDayOff,
                      ),
                      kGapH12,
                      Text(
                        'Lý do',
                        style: kTheme.textTheme.titleSmall?.copyWith(
                          color: kTheme.hintColor,
                        ),
                      ),
                      kGapH4,
                      TextFormField(
                        initialValue: controller.reason.value,
                        onChanged: (value) => controller.reason.value = value,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Nhập lý do cho ngày nghỉ này',
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: controller.addDayOff,
                          child: const Text('Thêm'),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
