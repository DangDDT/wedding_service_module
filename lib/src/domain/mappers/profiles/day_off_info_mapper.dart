import 'package:wedding_service_module/core/constants/default_value_mapper_constants.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wss_repository/entities/day_off.dart';

import '../base/base_data_mapper_profile.dart';

class DayOffInfoMapper extends BaseDataMapperProfile<DayOff, DayOffInfoModel> {
  @override
  DayOffInfoModel mapData(DayOff entity, Mapper mapper) {
    return DayOffInfoModel(
      id: entity.id.toString(),
      reason: entity.reason?.toString() ?? '',
      date: entity.day ?? DefaultValueMapperConstants.defaultDateTimeValue,

      ///TODO: đợi api Cung cấp thêm thông tin về dịch vụ cưới trong ngày bận
      weddingService: WeddingServiceDayOffInfo(
        id: DefaultValueMapperConstants.defaultStringValue,
        listImage: [],
        name: DefaultValueMapperConstants.defaultStringValue,
      ),
    );
  }
}
