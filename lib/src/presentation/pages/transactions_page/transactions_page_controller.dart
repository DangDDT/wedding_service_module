import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/core/module_configs.dart';
import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wss_repository/wss_repository.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';

class TransactionsPageController extends GetxController {
  final _weddingServiceService = Get.find<IWeddingServiceService>();
  final Rx<NullableDateRange> dateRange = const NullableDateRange().obs;
  final ModuleConfig config = ModuleConfig.instance;
  static const _pageSize = 20;
  final status = TransactionStatus.all.obs;
  final pagingController = PagingController<int, TransactionModel>(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_onLoadMore);
  }

  void changeStatus(int index) {
    final statusX = TransactionStatusX.getStatusFromIndexTab(index);
    status.value = statusX;
    pagingController.refresh();
  }

  void changeDateRange(NullableDateRange? dateRange) {
    if (dateRange == null) {
      return;
    }
    this.dateRange.value = dateRange;
    pagingController.refresh();
  }

  Future<void> _onLoadMore(int pageKey) async {
    // final newItems = await _fetchPage(pageKey);
    // final status = TransactionStatus.values[this.status.value];
    final newItems = await _weddingServiceService.getTransactions(
      GetPartnerPaymentHistoryParam(
        fromDate: dateRange.value.start?.firstTimeOfDate(),
        toDate: dateRange.value.end?.lastTimeOfDate(),
        status: status.value.toStringKeys(),
        page: pageKey,
        pageSize: _pageSize,
        sortKey: 'CreateDate',
        sortOrder: 'DESC',
      ),
    )
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey++;
      pagingController.appendPage(newItems, nextPageKey);
    }
  }
}
