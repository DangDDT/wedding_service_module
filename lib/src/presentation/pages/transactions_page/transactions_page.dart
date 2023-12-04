import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/presentation/pages/transactions_page/transactions_page_controller.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/widgets/stats_date_range_picker.dart';
import 'package:wedding_service_module/src/presentation/widgets/transaction_list_item.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _DateRangePicker(),
          ),
          Expanded(
            child: _TransactionsView(),
          ),
        ],
      ),
    );
  }
}

class _DateRangePicker extends StatelessWidget {
  const _DateRangePicker();

  @override
  Widget build(BuildContext context) {
    return StatsDateRangePicker(
      value: null,
      onDateRangeChanged: (NullableDateRange value) {},
    );
  }
}

class _TransactionsView extends GetView<TransactionsPageController> {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, TransactionModel>.separated(
      pagingController: controller.pagingController,
      separatorBuilder: (context, index) => const Divider(
        height: 0,
        thickness: .5,
        indent: 24,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        noItemsFoundIndicatorBuilder: (context) => const SizedBox(
          height: 310,
          child: Center(
            child: Text('Không có giao dịch nào'),
          ),
        ),
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 3.5,
                ),
              ),
            ),
          ),
        ),
        firstPageProgressIndicatorBuilder: (context) => const SizedBox(
          height: 310,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        itemBuilder: (context, item, index) {
          return TransactionListItem(transactionModel: item);
        },
      ),
    );
  }
}
