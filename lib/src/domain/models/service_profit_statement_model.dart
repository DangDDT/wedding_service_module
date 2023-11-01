// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfitStatementModel {
  const ProfitStatementModel({
    required this.totalProductProvided,
    required this.totalRevenue,
    required this.totalOrder,
  });

  final int? totalProductProvided;
  final double? totalRevenue;
  final int? totalOrder;
}
