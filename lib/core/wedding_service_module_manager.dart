import 'package:get/get.dart';
import 'package:wedding_service_module/core/global_binding.dart';
import 'package:wedding_service_module/core/l10n/_translate_manager.dart';
import 'package:wedding_service_module/core/module_configs.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import '../src/infrastructure/local_databases/isar/isar_database.dart';

// export '../src/presentation/views/public_view.dart';

class WeddingServiceModule {
  static const packageName = "wedding_service_module-$version";

  static const version = "1.0.0";
  static List<GetPage<dynamic>> get pageRoutes => ModuleRouter.routes;
  static TranslateManager get l10n => TranslateManager();

  static bool _isInitialized = false;

  static Future<void> init({
    bool isShowLog = false,
    required BaseUrlConfig baseUrlConfig,
    AuthConfig? authConfig,
  }) async {
    await IsarDatabase.init();
    await GlobalBinding.setUpLocator(
      isShowLog: isShowLog,
      baseUrlConfig: baseUrlConfig,
    );
    _isInitialized = true;
  }

  static void _assertInitialized() {
    if (!_isInitialized) {
      throw AssertionError(
        'UserModule is not initialized. Please call UserModule.init() before using any methods of UserModule.',
      );
    }
  }

  static Future<void> login(
      {required UserConfig userConfig, AuthConfig? authConfig}) async {
    _assertInitialized();
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setUserConfig = userConfig;
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setAuthConfig = authConfig;
  }

  static Future<void> logout() async {
    _assertInitialized();
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setUserConfig = null;
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setAuthConfig = null;
  }
}
