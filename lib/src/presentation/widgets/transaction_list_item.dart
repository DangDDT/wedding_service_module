import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/color_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';
import 'package:wedding_service_module/src/domain/models/transaction_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.transactionModel,
  });

  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    final transactionColor = transactionModel.status.color;
    return WrappedInkWell(
      onTap: () {},
      child: Container(
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
                      transactionModel.createdAt.toReadable(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.hintColor,
                      ),
                    ),
                    Text(
                      transactionModel.status.isPaid
                          ? 'Đã thanh toán ${transactionModel.paidAt != null ? 'vào ${transactionModel.paidAt!.toReadable()}' : ''}'
                          : 'Đang chờ',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.hintColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '+${transactionModel.amount.toVietNamCurrency()}',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
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
    );
  }
}
