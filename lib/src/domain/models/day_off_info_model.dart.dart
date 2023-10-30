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
  final WeddingServiceModel weddingService;
  final int? linkedTaskId;
}
