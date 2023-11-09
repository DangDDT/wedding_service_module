import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/mappers/z_mapper.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/domain/requests/get_day_offs_param.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wss_repository/entities/day_off.dart';
import 'package:wss_repository/wss_repository.dart';

class PartnerDayOffService implements IPartnerDayOffService {
  final _dayOffRepo = Get.find<IDayOffRepository>();
  final _mapper = Mapper.instance;
  @override
  Future<DayOffInfoModel> createPartnerDayOff(
    DayOffInfoModel partnerDayOff,
  ) async {
    final result = await _dayOffRepo.post(
      body: PostDayOffBody(
        day: partnerDayOff.date,
        reason: partnerDayOff.reason,
        serviceId: partnerDayOff.id,
      ),
    );

    return _mapper.mapData<DayOff, DayOffInfoModel>(result);
  }

  @override
  Future<bool> deletePartnerDayOff(String id) async {
    await _dayOffRepo.delete(id: id);
    return true;
  }

  @override
  Future<List<DayOffInfoModel>> getPartnerDayOffs(
      GetDayOffParams params) async {
    final result = await _dayOffRepo.getDayOffs(
      param: GetDayOffParam(
        fromDate: params.dateRange.start,
        toDate: params.dateRange.end,
        status: null,
        page: params.page,
        pageSize: params.pageSize,
        sortKey: null,
        sortOrder: null,
      ),
    );

    if (result.data == null) return [];

    return _mapper.mapListData<DayOff, DayOffInfoModel>(result.data!);
  }

  @override
  Future<bool> updatePartnerDayOff(DayOffInfoModel partnerDayOff) {
    // TODO: implement updatePartnerDayOff
    throw UnimplementedError();
  }
}
