import 'package:core_picker/core/core_picker.dart';
import 'package:example/l10n/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/wedding_service_module.dart' as wds;
import 'package:wss_repository/wss_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WssRepository.init(
    isShowDioLogger: true,
    authConfig: AuthConfig(
      accessToken: () async =>
          'eyJhbGciOiJSUzI1NiIsImtpZCI6IjBkMGU4NmJkNjQ3NDBjYWQyNDc1NjI4ZGEyZWM0OTZkZjUyYWRiNWQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoic3RyaW5nIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dlZGRpbmctc2VydmljZS13c3MiLCJhdWQiOiJ3ZWRkaW5nLXNlcnZpY2Utd3NzIiwiYXV0aF90aW1lIjoxNjk5MDI1NDQ3LCJ1c2VyX2lkIjoiZTRiODUzODUtZmQ2NC00ZmY5LWIxMDgtZjcwZmE4M2E5Y2I0Iiwic3ViIjoiZTRiODUzODUtZmQ2NC00ZmY5LWIxMDgtZjcwZmE4M2E5Y2I0IiwiaWF0IjoxNjk5MDI1NDQ3LCJleHAiOjE2OTkwMjkwNDcsImVtYWlsIjoid3BzX3Rlc3RfcGFydG5lckBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInBob25lX251bWJlciI6Iis4NDM2OTIyMjMxMSIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsid3BzX3Rlc3RfcGFydG5lckBnbWFpbC5jb20iXSwicGhvbmUiOlsiKzg0MzY5MjIyMzExIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.MR0d9O4RoAthdzN8n3cX_iID44iVJHuElrqlbzrrpGVS0SzWHoG2Ke0dMjQDZtTnWgB635Q5NP38aX-jG0Ra7N8IJ3kfP-HEOnJ5ItD5qtlb6yp-hokD7YaK2_6Kus-mbGKDDopqUo8Y9jlxsGsBtv9cpmrNs2GV_0SGVTUtvTg2qMhMfitTJIDuFfkbnB-zwrsHYh8SzcttV1HiZmeJESjsW8MD_Bh8wicBCWVWvdL8q-6_JVV6Va-tWlbde-dpxgluN77Ziyu63hiIwvFu5Slu7JfGKDfupbKZg_I2Exv3HmE02b8PJKApRWrPqTa7f5LbfxrWVjony-MediMfow',
      onRefreshTokenCallback: null,
      onUnauthorizedCallback: null,
    ),
  );
  await wds.WeddingServiceModule.init(
    isShowLog: true,
    baseUrlConfig: wds.BaseUrlConfig(baseUrl: ''),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorSheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 240, 141, 71),
    );
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: Translator(),
      theme: ThemeData(
        colorScheme: colorSheme,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          // contentPadding: EdgeInsets.symmetric(
          //   horizontal: 16,
          //   vertical: 12,
          // ),
          alignLabelWithHint: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          filled: true,
          fillColor: colorSheme.surfaceVariant,
        ),
      ),
      locale: const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      initialRoute: Router.page,
      getPages: Router.routes,
      onReady: () async {
        await wds.WeddingServiceModule.login(
          userConfig: const wds.UserConfig(userId: 12),
          onGetMyCategoryCallback: () async {
            return wds.ServiceCategoryModel.empty();
          },
        );
      },
    );
  }
}

class PageViewController extends GetxController {
  final pages = <Widget>[
    const wds.PartnerServiceDashboardPage(),
    const DashboardPage(),
  ];
  final currentIndex = 0.obs;
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PageViewController(),
      builder: (controller) => Scaffold(
        body: Obx(
          () => controller.pages[controller.currentIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Router {
  static const page = '/page';
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: page,
      page: () => const Page(),
    ),
    ...wds.WeddingServiceModule.pageRoutes,
    ...CorePicker.pageRoutes,
  ];
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(wds.WeddingServiceModule.pageRoutes[0].name);
          },
          child: const Text('Go to Wedding Service'),
        ),
      ),
    );
  }
}
