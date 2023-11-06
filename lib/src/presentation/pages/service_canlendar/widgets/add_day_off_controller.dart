import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/core/utils/extensions/paging_controller_ext.dart';
import 'package:wedding_service_module/core/utils/helpers/logger.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/domain/requests/get_wedding_service_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';

class AddDayOffController extends GetxController {
  final _weddingServiceService = Get.find<IWeddingServiceService>();

  final _partnerDayOffService = Get.find<IPartnerDayOffService>();
  final selectedWeddingService = Rxn<WeddingServiceModel>();
  final selectedDate = Rxn<DateTime>();
  final reason = RxString('');
  final addingState = Rx<LoadingState>(LoadingState.idle);
  late final PagingController<int, WeddingServiceModel> pagingController;
  late final TextEditingController searchController;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  AddDayOffController({
    WeddingServiceModel? weddingService,
    DateTime? date,
  });

  @override
  void onInit() {
    searchController = TextEditingController()
      ..addListener(() {
        _debouncer.call(() {
          pagingController.refresh();
        });
      });
    if (selectedWeddingService.value == null) {
      pagingController =
          PagingController<int, WeddingServiceModel>(firstPageKey: 0)
            ..addFetchPage(fetchServices);
    }
    super.onInit();
  }

  Future<List<WeddingServiceModel>> fetchServices(int pageKey) async {
    try {
      final data = await _weddingServiceService.getServices(
        GetWeddingServiceParam(
          status: WeddingServiceState.active,
          fromDate: null,
          toDate: null,
          categoryId: null,
          name: null,
          priceFrom: null,
          priceTo: null,
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

  Future<void> pickDayOff() async {
    final context = Get.context;
    if (context == null) return;
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 100),
    );

    if (result == null) return;

    selectedDate.value = result;
  }

  Future<void> addDayOff() async {
    try {
      addingState.value = LoadingState.loading;
      final weddingService = selectedWeddingService.value;
      if (weddingService == null) {
        throw Exception('Vui lòng chọn dịch vụ');
      }
      final date = selectedDate.value;
      if (date == null) {
        throw Exception('Vui lòng chọn ngày');
      }
      final reason = this.reason.value;
      if (reason.isEmpty) {
        throw Exception('Vui lòng nhập lý do');
      }
      final addedDayOff = await _partnerDayOffService.createPartnerDayOff(
        DayOffInfoModel(
          id: '-1',
          reason: reason,
          date: date,
          weddingService: WeddingServiceDayOffInfo.fromService(
            service: weddingService,
          ),
        ),
      );
      Get.back(result: addedDayOff);
    } catch (e, stackTrace) {
      Logger.logCritical(
        e.toString(),
        stackTrace: stackTrace,
        exception: e,
        name: runtimeType.toString(),
      );
      addingState.value = LoadingState.error;
      rethrow;
    }
    addingState.value = LoadingState.success;
  }
}
