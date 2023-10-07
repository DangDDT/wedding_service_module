import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/router_configs.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/service_item_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/empty_handler.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

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
          appBar: _CustomAppBar(controller),
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
                  Expanded(child: _ServiceListView(controller)),
                ],
              );
            },
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
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  if (capPop) const BackButton(),
                  if (!controller.isShowSearch.value)
                    Text(
                      controller.registerServicePage
                          ? 'Đăng ký dịch vụ'
                          : 'Dịch vụ',
                      style: kTextTheme.titleLarge,
                    ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _SearchField(controller),
                    ),
                  )
                ],
              ),
            ),
            _ServiceStatusTab(controller),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _SearchField extends StatelessWidget {
  const _SearchField(this.controller);

  final WeddingServicesPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
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
              duration: const Duration(milliseconds: 310),
              child: Visibility(
                visible: controller.isShowSearch.value,
                child: TextField(
                  focusNode: controller.searchFocusNode,
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  style: kTextTheme.bodyMedium,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 48,
                    ),
                    border: InputBorder.none,
                    filled: false,
                    hintText: 'Tìm kiếm theo tên dịch vụ',
                  ),
                ),
              ),
            ),
          ),
          if (controller.isHasSearchText.value)
            Visibility(
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              visible: controller.isHasSearchText.value,
              child: IconButton(
                onPressed: controller.clearSearch,
                icon: const Icon(Icons.clear),
              ),
            ),
        ],
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
    return DefaultTabController(
      length: viewState.length,
      child: TabBar(
        isScrollable: true,
        onTap: (index) => controller.changeStateTab(viewState[index]),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,
        unselectedLabelColor: kTheme.disabledColor,
        tabs: viewState.map((e) => Tab(child: Text(e.title))).toList(),
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
        return EmptyErrorHandler(
          title: 'Không có dịch vụ nào',
          reloadCallback: controller.fetchServices,
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
