import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PagingControllerExt<T> on PagingController<int, T> {
  int get defaultPageSize => _defaultPageSize;
  static const _defaultPageSize = 10;
  void addFetchPage(
    Future<List<T>> Function(int pageKey) fetchPage,
  ) {
    addPageRequestListener((pageKey) async {
      try {
        final newItems = await fetchPage(pageKey);
        final isLastPage = newItems.length < _defaultPageSize;
        if (isLastPage) {
          appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          appendPage(newItems, nextPageKey);
        }
      } catch (e) {
        error = e;
      }
    });
  }
}
