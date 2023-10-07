// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';

class PartnerServiceModel {
  const PartnerServiceModel({
    required this.id,
    required this.totalProductProvided,
    required this.totalRevenue,
    required this.totalOrder,
    required this.state,
    required this.registeredAt,
  });

  final String id;
  final int? totalProductProvided;
  final double? totalRevenue;
  final int? totalOrder;
  final WeddingServiceState state;
  final DateTime registeredAt;
}
