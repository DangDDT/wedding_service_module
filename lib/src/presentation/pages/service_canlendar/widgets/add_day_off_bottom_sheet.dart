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

class AddDayOffBottomSheet extends StatelessWidget {
  const AddDayOffBottomSheet({
    super.key,
    this.selectedService,
    this.selectedDate,
  });

  final WeddingServiceModel? selectedService;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDayOffController>(
      init: AddDayOffController(
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
        separatorBuilder: (context, index) => kGapH12,
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
    return ListTile(
      onTap: () => controller.selectedWeddingService.value = service,
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
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ),
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
