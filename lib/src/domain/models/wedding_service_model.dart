import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/service_profit_statement_model.dart';
import 'image_model.dart';

class WeddingServiceModel {
  WeddingServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.unit,
    required this.price,
    required this.actualRevenue,
    required this.commissionRate,
    required this.coverImage,
    required this.images,
    required this.profitStatement,
    required this.state,
    required this.rating,
    required this.registeredAt,
  });

  final String id;
  final String name;
  final String description;
  final String unit;
  final double? price;
  final String coverImage;

  /// Actual revenue of this service, which the partner actually received
  final double? actualRevenue;

  /// Commission rate of this service, which is used to calculate the commission
  final double? commissionRate;

  /// List of images of this service
  final List<ImageModel> images;

  /// Profit and loss statement of this service
  final ProfitStatementModel? profitStatement;

  final WeddingServiceState state;

  final DateTime registeredAt;

  final double? rating;
}
