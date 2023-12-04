import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/src/domain/mock/dummy.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';

class TransactionsPageController extends GetxController {
  static const _pageSize = 20;
  final pagingController = PagingController<int, TransactionModel>(
    firstPageKey: 0,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_onLoadMore);
  }

  Future<void> _onLoadMore(int pageKey) async {
    // final newItems = await _fetchPage(pageKey);
    final newItems = DummyData()
        .transactions
        .skip(pageKey * _pageSize)
        .take(_pageSize)
        .toList();
    final isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey++;
      pagingController.appendPage(newItems, nextPageKey);
    }
  }
}
