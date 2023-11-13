// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';

class GetDayOffParams {
  const GetDayOffParams({
    required this.dateRange,
    this.serviceId,
    this.page,
    this.pageSize,
  });

  final String? serviceId;
  final NullableDateRange dateRange;
  final int? page;
  final int? pageSize;
}
