import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/presentation/pages/transactions_page/transactions_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/auto_centerd_item_listview.dart';
import 'package:wedding_service_module/src/presentation/widgets/stats_date_range_picker.dart';
import 'package:wedding_service_module/src/presentation/widgets/transaction_list_item.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsPageController>(
      init: TransactionsPageController(),
      builder: (controller) {
        return const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _DateRangePicker(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: _TransactionStatusChoice(),
            ),
            Expanded(
              child: _TransactionsView(),
            ),
          ],
        );
      },
    );
  }
}

class _TransactionStatusChoice extends GetView<TransactionsPageController> {
  const _TransactionStatusChoice();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AutoCenteredItemListView(
        currentIndex: controller.status.value.getIndexFromStatus(),
        height: 48,
        itemCount: 3,
        itemBuilder: (context, index) {
          final status = TransactionStatusX.getStatusFromIndexTab(index);
          String name = status.name;

          if (status.isAll) {
            name = 'Tất cả';
          }
          return GestureDetector(
            onTap: () => controller.changeStatus(index),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight:
                      controller.status.value.getIndexFromStatus() == index
                          ? FontWeight.w700
                          : FontWeight.normal,
                  color: controller.status.value.getIndexFromStatus() == index
                      ? context.theme.colorScheme.primary
                      : context.theme.hintColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DateRangePicker extends GetView<TransactionsPageController> {
  const _DateRangePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return StatsDateRangePicker(
        value: controller.dateRange.value,
        onDateRangeChanged: controller.changeDateRange,
      );
    });
  }
}

class _TransactionsView extends GetView<TransactionsPageController> {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.pagingController.refresh();
      },
      child: PagedListView<int, TransactionModel>.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      ),
    );
  }
}
