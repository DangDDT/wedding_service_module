// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wedding_service_module/src/domain/models/image_model.dart';

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
  final String id;
  final String name;
  final List<ImageModel> listImage;
  WeddingServiceDayOffInfo({
    required this.id,
    required this.name,
    required this.listImage,
  });
}
