import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/view_models/state_data_view_model.dart';
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
              if (!controller.recentTransactions.hasData) {
                return const Center(
                  child: Text('Không có giao dịch nào'),
                );
              }
              if (controller.recentTransactions.hasError) {
                return const Center(
                  child: Text('Lỗi khi tải dữ liệu'),
                );
              }
              if (controller.recentTransactions.isInitialLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                  thickness: .5,
                  indent: 24,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recentTransactions.value.data!.length,
                itemBuilder: (context, index) {
                  final transactionModel =
                      controller.recentTransactions.value.data![index];
                  return TransactionListItem(
                    transactionModel: transactionModel,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
