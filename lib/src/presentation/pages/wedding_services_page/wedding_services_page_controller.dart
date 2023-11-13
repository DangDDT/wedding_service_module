import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/core/utils/extensions/paging_controller_ext.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/services_list_filter/services_list_filter_bottomsheet.dart';
import 'package:wedding_service_module/src/presentation/view_models/services_list_filter_data.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';

class WeddingServicesPageController extends GetxController {
  WeddingServicesPageController({
    this.viewWeddingServiceStates = WeddingServiceState.values,
  });
  final _weddingServiceService = Get.find<IWeddingServiceService>();

  late final PagingController<int, WeddingServiceModel> pagingController;
  final List<WeddingServiceState> viewWeddingServiceStates;
  final isShowSearch = false.obs;
  final isHasSearchText = false.obs;
  late final TextEditingController searchController;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  late final FocusNode searchFocusNode;
  late final Rx<WeddingServiceState> currentStateTab;
  final filterData = Rxn<ServicesListFilterData>();

  @override
  void onInit() {
    pagingController =
        PagingController<int, WeddingServiceModel>(firstPageKey: 0)
          ..addFetchPage(fetchServices);
    currentStateTab = viewWeddingServiceStates.first.obs;
    searchFocusNode = FocusNode();
    searchController = TextEditingController()
      ..addListener(() {
        _debouncer.call(() {
          pagingController.refresh();
        });
      });
    ever(filterData, (callback) => pagingController.refresh());
    searchFocusNode.addListener(_onFocusChanged);
    searchController.addListener(_onTextEditingControllerChanged);
    super.onInit();
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
    pagingController.refresh();
  }

  Future<List<WeddingServiceModel>> fetchServices(int pageKey) async {
    try {
      final data = await _weddingServiceService.getServices(
        GetWeddingServiceParam(
          status: currentStateTab.value,
          fromDate: filterData.value?.dateRange?.start,
          toDate: filterData.value?.dateRange?.end,
          categoryId: null,
          name: searchController.text,
          priceFrom: filterData.value?.revenueRange.start,
          priceTo: filterData.value?.revenueRange.end,
          pageIndex: pageKey,
          pageSize: pagingController.defaultPageSize,
          orderBy: null,
          orderType: null,
        ),
      );
      return data;
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        exception: e,
        name: runtimeType.toString(),
      );
      rethrow;
    }
  }
}
