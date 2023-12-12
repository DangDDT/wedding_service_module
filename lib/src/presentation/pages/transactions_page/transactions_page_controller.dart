import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';
import 'package:wss_repository/wss_repository.dart';

class TransactionsPageController extends GetxController {
  final _weddingServiceService = Get.find<IWeddingServiceService>();

  static const _pageSize = 20;
  final status = 0.obs;
  final pagingController = PagingController<int, TransactionModel>(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_onLoadMore);
  }

  void changeStatus(int index) {
    status.value = index;
    pagingController.refresh();
  }

  Future<void> _onLoadMore(int pageKey) async {
    // final newItems = await _fetchPage(pageKey);
    // final status = TransactionStatus.values[this.status.value];
    final newItems = await _weddingServiceService.getTransactions(
      GetPartnerPaymentHistoryParam(
        page: pageKey,
        pageSize: _pageSize,
        sortKey: 'CreateDate',
        sortOrder: 'DESC',
      ),
    );
    // DummyData()
    //     .transactions
    //     .where((element) => status.isUnknown || element.status == status)
    //     .skip(pageKey * _pageSize)
    //     .take(_pageSize)
    //     .toList();
    final isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey++;
      pagingController.appendPage(newItems, nextPageKey);
    }
  }
}
