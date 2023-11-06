// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';

class DayOffInfoModel {
  const DayOffInfoModel({
    required this.id,
    required this.reason,
    required this.date,
    required this.weddingService,
    this.linkedTaskId,
  });

  final String id;
  final String reason;
  final DateTime date;
  final WeddingServiceDayOffInfo weddingService;
  final int? linkedTaskId;
}

class WeddingServiceDayOffInfo {
  const WeddingServiceDayOffInfo({
    required this.id,
    required this.name,
    required this.listImage,
  });

  factory WeddingServiceDayOffInfo.fromService({
    required WeddingServiceModel service,
  }) =>
      WeddingServiceDayOffInfo(
        id: service.id,
        name: service.name,
        listImage: service.images,
      );

  final String id;
  final String name;
  final List<ImageModel> listImage;
}
