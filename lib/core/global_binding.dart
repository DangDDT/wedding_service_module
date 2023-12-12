// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:wedding_service_module/src/domain/mappers/profiles/category_mapper.dart';
import 'package:wedding_service_module/src/domain/mappers/profiles/day_off_info_mapper.dart';
import 'package:wedding_service_module/src/domain/mappers/profiles/transaction_mapper.dart';
import 'package:wedding_service_module/src/domain/mappers/profiles/wedding_serivce_mapper.dart';
import 'package:wedding_service_module/src/domain/services/implements/partner_day_off_service.dart';
import 'package:wedding_service_module/src/domain/services/implements/wedding_service_service.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_partner_day_off_service.dart';
import 'package:wedding_service_module/src/domain/services/interfaces/i_wedding_service_service.dart';

import '../src/domain/mappers/z_mapper.dart';
import 'module_configs.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
  }) async {
    Get.put<ModuleConfig>(
      ModuleConfig(
        isShowLog: isShowLog,
        baseUrlConfig: baseUrlConfig,
      ),
      tag: ModuleConfig.tag,
    );

    Mapper.instance.registerMappers(
      [
        WeddingServiceMapper(),
        DayOffInfoMapper(),
        CategoryMapper(),
        TransactionMapper(),
      ],
    );
    Get.put<IWeddingServiceService>(
      WeddingServiceService(),
    );

    Get.put<IPartnerDayOffService>(
      PartnerDayOffService(),
    );

    // final dioClient = Get.put<DioClient>(
    //   DioClient(
    //     baseUrl: baseUrlConfig.baseUrl,
    //   ),
    //   tag: DioClient.tag,
    // );
  }
}
