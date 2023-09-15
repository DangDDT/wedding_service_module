import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:wedding_service_module/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  await Isar.initializeIsarCore();
  await WeddingServiceModule.init(
    isShowLog: true,
    baseUrlConfig: BaseUrlConfig(baseUrl: ''),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 240, 141, 71),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.arsenalTextTheme(),
      ),
      locale: const Locale('vi', 'VN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      initialRoute: Router.page,
      getPages: Router.routes,
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdsServiceView(),
              kGapH12,
              // CategoriesServiceView(),
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
    ...WeddingServiceModule.pageRoutes,
  ];
}
