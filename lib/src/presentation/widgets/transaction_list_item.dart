import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/module_configs.dart';
import 'package:wedding_service_module/core/utils/extensions/color_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.transactionModel,
  });

  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final config = ModuleConfig.instance;
    final transactionColor = transactionModel.status.color;
    return ExpansionTile(
      trailing: transactionModel.detailInfos.isNotEmpty
          ? const Icon(Icons.keyboard_arrow_down)
          : null,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      backgroundColor: transactionColor.withOpacity(.05),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints(minHeight: 78),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: transactionColor.lighten(.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: transactionColor,
                    foregroundColor: transactionColor.textColor,
                    child: transactionModel.status.icon,
                  ),
                ),
              ),
              kGapW12,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionModel.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      transactionModel.createdAt.toFullString(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.hintColor,
                      ),
                    ),
                    Text(
                      transactionModel.status.isPaid
                          ? 'Đã thanh toán'
                          : 'Đang chờ thanh toán',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: transactionColor,
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Tổng giá trị đơn hàng:',
                      ),
                      trailing: Text(
                        transactionModel.detailInfos
                            .fold<double>(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.price,
                            )
                            .toVietNamCurrency(),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        isThreeLine: true,
                        title: const Text(
                          'Doanh thu thực tế:',
                        ),
                        subtitle: const Text(
                          '(Đã trừ chiết khấu)',
                        ),
                        trailing: Text(
                          '+ ${transactionModel.amount.toVietNamCurrency()}',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        if (transactionModel.detailInfos.isNotEmpty)
          Column(
            children: transactionModel.detailInfos
                .where((e) => e.createBy == config.userConfig.userId)
                .map(
                  (e) => ListTile(
                    title: Text(e.serviceName),
                    subtitle: Text(e.address),
                    trailing: Text(
                      e.price.toVietNamCurrency(),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
