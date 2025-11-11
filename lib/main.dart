import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:point_system/app/modules/login/controllers/login_controller.dart';

import 'app/common/widgets/connection_overlay.dart';
import 'app/common/widgets/connectivity.dart';
import 'app/routes/app_pages.dart';
import 'app/localization/app_translations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "app_title".tr,
          initialBinding: BindingsBuilder(() {
            Get.put(LoginController());
            Get.put(ConnectivityController(),permanent: true);
          }),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: const Locale('ar'),
          fallbackLocale: const Locale('en'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: ThemeMode.light,

          defaultTransition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 500),
          theme: ThemeData(
            fontFamily: "IBMPlexSansArabic",
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          builder: (context, child) {
            final locale = Get.locale ?? const Locale('en');
            final direction = locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr;
            return Directionality(
              textDirection: direction,
              child: kDebugMode ? child! :Stack(
                  children: [
                    ConnectionOverlay(

                      child: child ?? const SizedBox(),
                    )
                  ]
              ),
            );;
          },
        );
      },
    ),
  );
}
