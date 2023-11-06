// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';

class GetWeddingServiceParam {
  final WeddingServiceState? status;
  // final DateTime? checkDate;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? categoryId;
  final String? name;
  final double? priceFrom;
  final double? priceTo;
  final int? pageIndex;
  final int? pageSize;
  final String? orderBy;
  final String? orderType;
  GetWeddingServiceParam({
    required this.status,
    // required this.checkDate,
    required this.fromDate,
    required this.toDate,
    required this.categoryId,
    required this.name,
    required this.priceFrom,
    required this.priceTo,
    required this.pageIndex,
    required this.pageSize,
    required this.orderBy,
    required this.orderType,
  });
}
