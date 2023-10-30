// ignore_for_file: void_checks

import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/service_calendar_page_binding.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/service_canlendar_page.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_dedail_page_bindings.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/service_register_page.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/service_register_page_binding.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/wedding_services_page.dart';

class ModuleRouter {
  static String weddingServicesRoute = '/wedding_services';
  static String weddingServiceDetailRoute = '/wedding_service_detail';
  static String weddingServiceRegisterRoute = '/wedding_service_register';
  static String weddingServiceCalendarRoute = '/wedding_service_calendar';

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
    GetPage<dynamic>(
      name: weddingServiceRegisterRoute,
      binding: ServiceRegisterPageBinding(),
      page: () => const ServiceRegisterPage(),
    ),
    GetPage<dynamic>(
      name: weddingServiceCalendarRoute,
      binding: ServiceCalendarPageBinding(),
      page: () => const ServiceCalendarPage(),
    ),
  ];
}
