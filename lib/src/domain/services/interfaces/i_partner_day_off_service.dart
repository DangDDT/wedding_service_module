import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/requests/get_day_offs_param.dart';

abstract interface class IPartnerDayOffService {
  Future<List<DayOffInfoModel>> getPartnerDayOffs(GetDayOffParams params);
  Future<DayOffInfoModel> createPartnerDayOff(DayOffInfoModel partnerDayOff);
  Future<bool> updatePartnerDayOff(DayOffInfoModel partnerDayOff);
  Future<bool> deletePartnerDayOff(String id);
}
