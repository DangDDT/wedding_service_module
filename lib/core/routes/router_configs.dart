// ignore_for_file: void_checks

import 'package:get/get.dart';
import 'package:wedding_service_module/src/presentation/pages/categories_service/categories_service_page.dart';

import 'router_constant.dart';

class ModuleRouter {
  static final List<GetPage> routes = [
    //  GetPage<dynamic>(
    //   name: route_name,
    //   page: () => const PageName(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => PageNameCtrl());
    //     ...
    //   }),
    // ),
    GetPage<dynamic>(
      name: RouteConstants.categoriesServiceRoute,
      page: () => const CategoriesServicePage(),
    ),
  ];
}
