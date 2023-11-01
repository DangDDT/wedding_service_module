import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/mock/dummy.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/services_list_filter/services_list_filter_bottomsheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/services_list_filter_data.dart';

class WeddingServicesPageController extends GetxController
    with StateMixin<List<WeddingServiceModel>> {
  WeddingServicesPageController({
    this.viewWeddingServiceStates = const [
      WeddingServiceState.active,
      WeddingServiceState.suspended,
    ],
  });

  final List<WeddingServiceState> viewWeddingServiceStates;
  final isShowSearch = false.obs;
  final isHasSearchText = false.obs;
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  late final Rx<WeddingServiceState> currentStateTab;
  final filterData = Rxn<ServicesListFilterData>();

  @override
  void onInit() {
    currentStateTab = viewWeddingServiceStates.first.obs;
    searchFocusNode = FocusNode();
    searchController = TextEditingController();
    searchFocusNode.addListener(_onFocusChanged);
    searchController.addListener(_onTextEditingControllerChanged);
    super.onInit();
    fetchServices();
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _onFocusChanged() {
    if (searchFocusNode.hasFocus) {
      isShowSearch.value = true;
    }

    if (!searchFocusNode.hasFocus && searchController.text.isEmpty) {
      isShowSearch.value = false;
    }
  }

  void _onTextEditingControllerChanged() {
    final isNotEmpty = searchController.text.isNotEmpty;
    if (isNotEmpty != isHasSearchText.value) {
      isHasSearchText.value = isNotEmpty;
    }
  }

  void showFilter() async {
    final data = await ServicesListFilterBottomSheet.show(
      initialData: filterData.value,
      // registerDateRange: false,
    );
    if (data != null) {
      filterData.value = data;
    }
  }

  void clearSearch() {
    searchController.clear();
    if (!searchFocusNode.hasFocus) {
      isShowSearch.value = false;
    }
  }

  void changeStateTab(WeddingServiceState state) {
    currentStateTab.value = state;
    fetchServices();
  }

  Future<void> fetchServices() async {
    change(state, status: RxStatus.loading());
    try {
      //TODO: call api
      final data = Dummy.services
          .where(
            (element) => (element.profitStatement != null &&
                element.state == currentStateTab.value),
          )
          .toList();
      change(data, status: RxStatus.success());
    } catch (e, stackTrace) {
      change(state, status: RxStatus.error('Có lỗi xảy ra, vui lòng thử lại'));
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        exception: e,
        name: runtimeType.toString(),
      );
    }
  }
}
