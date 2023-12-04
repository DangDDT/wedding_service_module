import 'package:wedding_service_module/src/domain/enums/private/transaction_status.dart';

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    this.paidAt,
    required this.status,
  });

  final String id;
  final String title;
  final String? description;
  final double amount;
  final DateTime createdAt;
  final DateTime? paidAt;
  final TransactionStatus status;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.paidAt == paidAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        createdAt.hashCode ^
        paidAt.hashCode ^
        status.hashCode;
  }
}
