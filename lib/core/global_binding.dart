// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../src/domain/domain.dart';
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

    Mapper.instance.registerMappers([]);

    // final dioClient = Get.put<DioClient>(
    //   DioClient(
    //     baseUrl: baseUrlConfig.baseUrl,
    //   ),
    //   tag: DioClient.tag,
    // );
  }
}
