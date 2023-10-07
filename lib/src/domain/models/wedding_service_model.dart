import 'package:wedding_service_module/src/domain/models/partner_service.dart';

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
    required this.partnerService,
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

  final PartnerServiceModel? partnerService;
}
