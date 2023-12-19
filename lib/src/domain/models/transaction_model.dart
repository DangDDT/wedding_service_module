// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.detailInfos,
  });

  final String id;
  final String title;
  final String? description;
  final double amount;
  final DateTime createdAt;
  final DateTime? paidAt;
  final TransactionStatus status;
  final List<TransactionDetailInfo> detailInfos;

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

class TransactionDetailInfo {
  final String serviceName;
  final String address;
  final double price;
  final String createBy;
  TransactionDetailInfo({
    required this.serviceName,
    required this.address,
    required this.price,
    required this.createBy,
  });
}
