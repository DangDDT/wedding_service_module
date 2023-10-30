import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/color_ext.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/custom_chip.dart';

class RecentTransactionsView
    extends GetView<PartnerServiceDashboardPageController> {
  const RecentTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: () {},
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        kGapH8,
        ListView.separated(
          separatorBuilder: (context, index) => kGapH8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // itemCount: controller.recentTransactions.length,
          itemCount: 3,
          itemBuilder: (context, index) {
            return const _TransactionListItem();
          },
        ),
      ],
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  const _TransactionListItem();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      style: ListTileStyle.list,
      horizontalTitleGap: 12,
      isThreeLine: true,
      minVerticalPadding: 14,
      // tileColor: context.theme.colorScheme.primaryContainer.withOpacity(.4),
      tileColor: Colors.grey.lighten(.3),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.green.lighten(.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Text(
        'Dịch vụ 145A',
        style: context.textTheme.titleMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            UnconstrainedBox(
              child: CustomChip(
                label: const Text('Đã thanh toán'),
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
      trailing: Text(
        '+1.000.000đ',
        style: context.textTheme.titleMedium?.copyWith(
          color: Colors.green.shade700,
        ),
      ),
    );
  }
}
