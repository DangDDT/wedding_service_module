import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/transaction_list_item.dart';

class RecentTransactionsView
    extends GetView<PartnerServiceDashboardPageController> {
  const RecentTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 410),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Lịch sử thanh toán',
                  style: context.textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(ModuleRouter.transactionsRoute),
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
          kGapH8,
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 140),
            child: Obx(() {
              switch (controller.recentTransactions.value.status) {
                case LoadingState.initial:
                  return const SizedBox.shrink();
                case LoadingState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case LoadingState.error:
                  return Center(
                    child: Column(
                      children: [
                        const Text('Lỗi khi tải dữ liệu'),
                        kGapH8,
                        FilledButton.tonal(
                          onPressed: controller.fetchRecentTransactions,
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  );
                case LoadingState.empty:
                  return Center(
                    child: Column(
                      children: [
                        const Text('Không có giao dịch nào'),
                        kGapH8,
                        FilledButton.tonal(
                          onPressed: controller.fetchRecentTransactions,
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  );
                case LoadingState.success:
                  return RefreshIndicator(
                    onRefresh: controller.refresh,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => const Divider(
                        height: 0,
                        thickness: .5,
                        indent: 24,
                      ),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount:
                          controller.recentTransactions.value.data!.length,
                      itemBuilder: (context, index) {
                        final transactionModel =
                            controller.recentTransactions.value.data![index];
                        return TransactionListItem(
                          transactionModel: transactionModel,
                        );
                      },
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
