import 'package:flutter/material.dart';

enum TransactionStatus {
  pending,
  paid,
  unknown,
}

extension TransactionStatusX on TransactionStatus {
  bool get isPaid => this == TransactionStatus.paid;
  bool get isPending => this == TransactionStatus.pending;
  bool get isUnknown => this == TransactionStatus.unknown;

  String get name {
    switch (this) {
      case TransactionStatus.pending:
        return 'Đang chờ';
      case TransactionStatus.paid:
        return 'Đã thanh toán';
      default:
        return 'Không xác định';
    }
  }

  Widget get icon {
    switch (this) {
      case TransactionStatus.pending:
        return const Icon(Icons.watch_later_outlined);
      case TransactionStatus.paid:
        return const Icon(Icons.check);
      default:
        return const Icon(Icons.help);
    }
  }

  Color get color {
    switch (this) {
      case TransactionStatus.pending:
        return Colors.orange.shade800;
      case TransactionStatus.paid:
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }
}
