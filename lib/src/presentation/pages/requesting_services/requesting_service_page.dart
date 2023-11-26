import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/requesting_services/widgets/service_list_view_item_widget.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/auto_centerd_item_listview.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/radio_filter_button.dart';

class RequestingServicePage extends GetView<WeddingServicesPageController> {
  static const String bindingTag = 'RequestingServicePage';
  @override
  String? get tag => bindingTag;
  const RequestingServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: const _CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () => Get.toNamed(
            ModuleRouter.weddingServiceRegisterRoute,
          ),
          child: const Icon(Icons.add),
        ),
        body: const _ServiceListView(),
      ),
    );
  }
}

class _CustomAppBar extends GetView<WeddingServicesPageController>
    implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  String? get tag => RequestingServicePage.bindingTag;

  @override
  Widget build(BuildContext context) {
    final capPop = Navigator.of(context).canPop();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Row(
                children: [
                  if (capPop) const BackButton(),
                  if (!controller.isShowSearch.value)
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Danh sách chờ duyệt',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextTheme.titleLarge,
                        ),
                      ),
                    ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _SearchField(),
                    ),
                  ),
                  kGapW4,
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey.shade200,
                      ),
                      iconColor: MaterialStateProperty.all(
                        context.theme.hintColor,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    onPressed: controller.showFilter,
                    icon: const Icon(CupertinoIcons.slider_horizontal_3),
                  ),
                ],
              ),
            ),
            kGapH16,
            const Align(
              alignment: Alignment.centerLeft,
              child: _ServiceStatusTab(),
            ),
            kGapH8,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.5);
}

class _SearchField extends GetView<WeddingServicesPageController> {
  const _SearchField();

  @override
  String get tag => RequestingServicePage.bindingTag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DecoratedBox(
        // duration: const Duration(milliseconds: 310),
        decoration: BoxDecoration(
          color: controller.isShowSearch.value
              ? Colors.grey.shade200
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: controller.isShowSearch.value
                  ? null
                  : () {
                      controller.isShowSearch.value =
                          !controller.isShowSearch.value;

                      controller.searchFocusNode.requestFocus();
                    },
              icon: const Icon(Icons.search),
            ),
            Flexible(
              child: AnimatedSize(
                alignment: Alignment.centerRight,
                duration: const Duration(milliseconds: 210),
                child: Visibility(
                  visible: controller.isShowSearch.value,
                  child: TextField(
                    focusNode: controller.searchFocusNode,
                    controller: controller.searchController,
                    textInputAction: TextInputAction.search,
                    style: kTextTheme.bodyMedium,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 48,
                      ),
                      border: InputBorder.none,
                      filled: false,
                      hintText: 'Tìm kiếm theo tên dịch vụ',
                      suffixIcon: Obx(
                        () => AnimatedOpacity(
                          duration: const Duration(milliseconds: 110),
                          opacity: controller.isHasSearchText.value ? 1 : 0,
                          child: IconButton(
                            style: ButtonStyle(
                              visualDensity: VisualDensity.compact,
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(0),
                              ),
                            ),
                            onPressed: controller.clearSearch,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // if (controller.isHasSearchText.value)
          ],
        ),
      ),
    );
  }
}

class _ServiceStatusTab extends GetView<WeddingServicesPageController> {
  const _ServiceStatusTab();

  @override
  String get tag => RequestingServicePage.bindingTag;

  @override
  Widget build(BuildContext context) {
    final viewState = controller.viewWeddingServiceStates;
    return Obx(
      () => AutoCenteredItemListView(
        height: 38,
        currentIndex: viewState.indexOf(controller.currentStateTab.value),
        itemCount: viewState.length,
        itemBuilder: itemBuilder,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = controller.viewWeddingServiceStates[index];
    return Obx(
      () => RadioFilterButton(
        onTap: () => controller.changeStateTab(state),
        selected: state == controller.currentStateTab.value,
        title: Text(state.title),
      ),
    );
  }
}

class _ServiceListView extends GetView<WeddingServicesPageController> {
  const _ServiceListView();
  @override
  String get tag => RequestingServicePage.bindingTag;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.pagingController.refresh(),
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
          itemBuilder: (context, item, index) {
            return ServiceListItemWidget(
              service: item,
              backgroundColor: context.theme.colorScheme.surfaceVariant,
              onTap: () => Get.toNamed(
                ModuleRouter.weddingServiceDetailRoute,
                arguments: {
                  'serviceId': item.id,
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
