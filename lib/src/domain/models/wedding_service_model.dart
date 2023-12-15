import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/domain/models/service_category_model.dart';
import 'package:wedding_service_module/src/domain/models/service_profit_statement_model.dart';
import 'image_model.dart';

class WeddingServiceModel {
  WeddingServiceModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.unit,
    required this.price,
    required this.actualRevenue,
    required this.commissionRate,
    required this.coverImage,
    required this.category,
    required this.images,
    required this.profitStatement,
    required this.state,
    required this.rating,
    required this.registeredAt,
    required this.suspendedReason,
    required this.registerRejectedReason,
  });

  factory WeddingServiceModel.onRegister({
    required String name,
    required String description,
    required String unit,
    required double price,
    required ServiceCategoryModel category,
    required List<ImageModel> images,
  }) {
    return WeddingServiceModel(
      id: 'null',
      code: 'null',
      name: name,
      description: description,
      unit: unit,
      price: price,
      actualRevenue: null,
      commissionRate: null,
      coverImage: images.first.imageUrl,
      category: category,
      images: images,
      profitStatement: null,
      state: WeddingServiceState.active,
      rating: null,
      registeredAt: DateTime.now(),
      suspendedReason: null,
      registerRejectedReason: null,
    );
  }

  final String id;
  final String code;
  final String name;
  final String description;
  final String unit;
  final double price;
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

  final ServiceCategoryModel category;

  final DateTime registeredAt;

  final double? rating;

  final String? suspendedReason;

  final String? registerRejectedReason;
}
