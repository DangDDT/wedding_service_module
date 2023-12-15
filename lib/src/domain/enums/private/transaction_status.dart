import 'package:flutter/material.dart';

enum TransactionStatus {
  unknown,
  all,
  pending,
  paid,
}

extension TransactionStatusX on TransactionStatus {
  bool get isPaid => this == TransactionStatus.paid;
  bool get isAll => this == TransactionStatus.all;
  bool get isPending => this == TransactionStatus.pending;
  bool get isUnknown => this == TransactionStatus.unknown;

  List<String> toStringKeys() {
    switch (this) {
      case TransactionStatus.all:
        return [
          TransactionStatus.pending.toKey(),
          TransactionStatus.paid.toKey(),
        ];
      case TransactionStatus.pending:
        return [TransactionStatus.pending.toKey()];
      case TransactionStatus.paid:
        return [TransactionStatus.paid.toKey()];
      default:
        return [];
    }
  }

  static TransactionStatus getStatusFromIndexTab(int index) {
    switch (index) {
      case 0:
        return TransactionStatus.all;
      case 1:
        return TransactionStatus.pending;
      case 2:
        return TransactionStatus.paid;
      default:
        return TransactionStatus.unknown;
    }
  }

  int getIndexFromStatus() {
    switch (this) {
      case TransactionStatus.all:
        return 0;
      case TransactionStatus.pending:
        return 1;
      case TransactionStatus.paid:
        return 2;
      default:
        return -1;
    }
  }

  String get name {
    switch (this) {
      case TransactionStatus.all:
        return 'Tất cả';
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

  String toKey() {
    switch (this) {
      case TransactionStatus.pending:
        return 'INACTIVE';
      case TransactionStatus.paid:
        return 'ACTIVE';
      default:
        return 'UNKNOWN';
    }
  }

  static TransactionStatus fromCode(String? code) {
    switch (code) {
      case 'INACTIVE':
        return TransactionStatus.pending;
      case 'ACTIVE':
        return TransactionStatus.paid;
      default:
        return TransactionStatus.unknown;
    }
  }
}
