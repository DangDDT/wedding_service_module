// ignore_for_file: void_checks

import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_dedail_page_bindings.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page.dart';

class ModuleRouter {
  static String weddingServicesRoute = '/wedding_services';
  static String weddingServiceDetailRoute = '/wedding_service_detail';

  static final List<GetPage> routes = [
    GetPage<dynamic>(
      name: weddingServicesRoute,
      page: () => const WeddingServicesPage(),
    ),
    GetPage<dynamic>(
      name: weddingServiceDetailRoute,
      binding: ServiceDetailPageBindings(),
      page: () => const ServiceDetailPage(),
    ),
  ];
}
