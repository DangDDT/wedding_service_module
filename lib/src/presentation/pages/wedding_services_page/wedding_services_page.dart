import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/router_configs.dart';
import 'package:wedding_service_module/core/utils/extensions/list_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/service_item_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class WeddingServicesPage extends StatelessWidget {
  const WeddingServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final registerServicePage = arguments?['registerServicePage'] ?? false;
    return KeyboardDismisser(
      child: GetBuilder(
        init: WeddingServicesPageController(
          registerServicePage: registerServicePage,
        ),
        global: false,
        builder: (controller) => Scaffold(
          // appBar: _CustomAppBar(controller),
          floatingActionButton: controller.registerServicePage
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(
                      ModuleRouter.weddingServicesRoute,
                      arguments: {'registerServicePage': true},
                    );
                  },
                  child: const Icon(Icons.add),
                ),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _CustomAppBar(controller),
                ),
              ),
            ],
            body: SimpleBuilder(
              builder: (_) {
                if (controller.status.isLoading &&
                    (controller.state?.isEmpty ?? true)) {
                  return const Center(
                    child: LoadingWidget(
                      message: 'Đang lấy danh sách dịch vụ...',
                    ),
                  );
                } else if (controller.status.isError) {
                  return EmptyErrorHandler(
                    title: 'Có lỗi xảy ra, vui lòng thử lại',
                    reloadCallback: controller.fetchServices,
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: controller.registerServicePage
                          ? _ServiceListView(controller)
                          : _ServiceGridView(controller: controller),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar(this.controller);

  final WeddingServicesPageController controller;

  @override
  Widget build(BuildContext context) {
    final capPop = Navigator.of(context).canPop();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  if (capPop) const BackButton(),
                  if (!controller.isShowSearch.value)
                    Flexible(
                      flex: 0,
                      fit: FlexFit.tight,
                      child: Text(
                        controller.registerServicePage
                            ? 'Đăng ký dịch vụ'
                            : 'Dịch vụ',
                        maxLines: 1,
                        style: kTextTheme.titleLarge,
                      ),
                    ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _SearchField(controller),
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
            _ServiceStatusTab(controller),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.5);
}

class _SearchField extends StatelessWidget {
  const _SearchField(this.controller);

  final WeddingServicesPageController controller;

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
                      // isDense: true,
                      // contentPadding: const EdgeInsets.only(
                      //   top: 8,
                      //   bottom: 12,
                      // ),
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

class _ServiceStatusTab extends StatelessWidget {
  const _ServiceStatusTab(this.controller);

  final WeddingServicesPageController controller;

  @override
  Widget build(BuildContext context) {
    final viewState = controller.viewWeddingServiceStates;
    if (viewState.length > 2) {
      return SizedBox(
        height: kToolbarHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => kGapW8,
          itemBuilder: itemBuilder,
          itemCount: viewState.length,
        ),
      );
    }

    return Row(
      children: List.generate(
        viewState.length,
        (index) => itemBuilder(context, index),
      ).joinWidget(kGapW8),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final state = controller.viewWeddingServiceStates[index];
    return UnconstrainedBox(
      child: WrappedInkWell(
        onTap: () => controller.changeStateTab(state),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: state == controller.currentStateTab.value
                ? context.theme.colorScheme.primary
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            state.title,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: state == controller.currentStateTab.value
                  ? context.theme.colorScheme.onPrimary
                  : context.theme.hintColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceGridView extends StatelessWidget {
  final WeddingServicesPageController controller;

  const _ServiceGridView({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.state?.isEmpty ?? true) {
      return Center(
        child: EmptyErrorHandler(
          title: 'Không có dịch vụ nào',
          reloadCallback: controller.fetchServices,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: controller.fetchServices,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: controller.state!.length,
        itemBuilder: (_, index) {
          final service = controller.state![index];
          return ServiceItemWidget.gridView(
            service: service,
            onTap: () => Get.toNamed(
              ModuleRouter.weddingServiceDetailRoute,
              arguments: {
                'serviceId': service.id,
              },
            ),
          );
        },
      ),
    );
  }
}

class _ServiceListView extends StatelessWidget {
  const _ServiceListView(this.controller);

  final WeddingServicesPageController controller;

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(builder: (ctx) {
      if (controller.state?.isEmpty ?? true) {
        return Center(
          child: EmptyErrorHandler(
            title: 'Không có dịch vụ nào',
            reloadCallback: controller.fetchServices,
          ),
        );
      }

      return RefreshIndicator.adaptive(
        onRefresh: controller.fetchServices,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: controller.state!.length,
          separatorBuilder: (_, __) => kGapH8,
          itemBuilder: (_, index) {
            final service = controller.state![index];
            return ServiceItemWidget(
              service: service,
              onTap: () => Get.toNamed(
                ModuleRouter.weddingServiceDetailRoute,
                arguments: {
                  'serviceId': service.id,
                },
              ),
            );
          },
        ),
      );
    });
  }
}
