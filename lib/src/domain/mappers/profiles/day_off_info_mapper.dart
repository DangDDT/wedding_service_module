import 'package:wedding_service_module/core/constants/default_value_mapper_constants.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/models/image_model.dart';
import 'package:wss_repository/entities/day_off.dart';

import '../base/base_data_mapper_profile.dart';

class DayOffInfoMapper extends BaseDataMapperProfile<DayOff, DayOffInfoModel> {
  @override
  DayOffInfoModel mapData(DayOff entity, Mapper mapper) {
    final serviceImages = entity.service?.serviceImages
            .map((e) => ImageModel(id: e, imageUrl: e))
            .toList() ??
        [];
    if (entity.service?.coverUrl != null && serviceImages.isEmpty) {
      serviceImages.add(ImageModel(
        id: entity.service?.coverUrl,
        imageUrl: entity.service!.coverUrl!,
      ));
    }

    return DayOffInfoModel(
      id: entity.id.toString(),
      reason: entity.reason?.toString() ?? '',
      date: entity.day ?? DefaultValueMapperConstants.defaultDateTimeValue,
      weddingService: WeddingServiceDayOffInfo(
        id: entity.service?.id ??
            DefaultValueMapperConstants.defaultStringValue,
        listImage: serviceImages,
        name: entity.service?.name ??
            DefaultValueMapperConstants.defaultStringValue,
      ),
    );
  }
}
