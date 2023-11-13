import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/service_grid_item_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/auto_centerd_item_listview.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/radio_filter_button.dart';

import '../../widgets/empty_handler.dart';

class WeddingServicesPage extends StatelessWidget {
  const WeddingServicesPage({super.key});

  // @override
  // String? get tag => bindingTag;

  static const bindingTag = 'WeddingServicesPage';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: WeddingServicesPageController(),
      tag: bindingTag,
      builder: (ctl) => KeyboardDismisser(
        child: Scaffold(
          // appBar: _CustomAppBar(controller),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Get.toNamed(
              ModuleRouter.weddingServiceRegisterRoute,
            ),
            label: const Text('Thêm mới'),
            icon: const Icon(Icons.add),
            // child: const Text('Thêm mới'),
          ),
          // floatingActionButton: ExpandableFab(
          //   directAction: ActionButton(
          //     onPressed: () => Get.toNamed(
          //       ModuleRouter.weddingServiceRegisterRoute,
          //     ),
          //     label: const Text('Thêm mới'),
          //     icon: const Icon(CupertinoIcons.add),
          //   ),
          //   actions: [
          //     ActionButton(
          //       onPressed: () => Get.toNamed(
          //         ModuleRouter.requestingServiceRoute,
          //       ),
          //       label: const Text('Danh sách chờ duyệt'),
          //       icon: const Icon(Icons.pending_actions),
          //     ),
          //   ],
          // ),
          body: const Scaffold(
            appBar: _CustomAppBar(),
            body: _ServiceGridView(),
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends GetView<WeddingServicesPageController>
    implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  String? get tag => WeddingServicesPage.bindingTag;

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
                      flex: 0,
                      fit: FlexFit.tight,
                      child: AutoSizeText(
                        'Dịch vụ',
                        maxLines: 1,
                        style: kTextTheme.titleLarge,
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
              child: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: _ServiceStatusTab(),
              ),
            ),
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
  String? get tag => WeddingServicesPage.bindingTag;

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
  String? get tag => WeddingServicesPage.bindingTag;

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

class _ServiceGridView extends GetView<WeddingServicesPageController> {
  const _ServiceGridView();

  @override
  String? get tag => WeddingServicesPage.bindingTag;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.pagingController.refresh(),
      child: PagedGridView<int, WeddingServiceModel>(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        pagingController: controller.pagingController,
        showNoMoreItemsIndicatorAsGridChild: false,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .66,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
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
          itemBuilder: (context, item, index) {
            return ServiceGridItemWidget(
              service: item,
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
