import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:point_system/app/constants/colors.dart';
import 'package:point_system/app/modules/login/controllers/login_controller.dart';
import 'package:toastification/toastification.dart';

import 'app/common/widgets/connection_overlay.dart';
import 'app/common/widgets/connectivity.dart';
import 'app/routes/app_pages.dart';
import 'app/localization/app_translations.dart';
import 'app/services/api/api_service.dart';
import 'app/services/auth/auth_service.dart';
import 'app/services/home/home_service.dart';

main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light,
    ),
  );
  final dm = await getManufacturer();
  await Hive.initFlutter();
  final appData = await Hive.openBox('appData');
  appData.put("deviceManufacture", dm);

  await Hive.openBox('auth');

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      splitScreenMode: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          overlayColor: Colors.white.withOpacity(0.5),
          
          overlayWholeScreen: true,
          closeOnBackButton: true,
          overlayWidgetBuilder: (progress) {
            return  Center(
              child: SpinKitFadingCircle(color: AppColors.primary,),
            );
          },
          child: ToastificationWrapper(

            child: GetMaterialApp(
              title: "app_title".tr,
              initialBinding: InitialBindings(),
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
                  child: kDebugMode
                      ? child!
                      : Stack(
                          children: [
                            ConnectionOverlay(child: child ?? const SizedBox()),
                          ],
                        ),
                );
                ;
              },
            ),
          ),
        );
      },
    ),
  );
}

Future<String?> getManufacturer() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final android = await deviceInfo.androidInfo;
    return android.manufacturer;         // e.g. Samsung, Xiaomi, Tecno
  } else if (Platform.isIOS) {
    final ios = await deviceInfo.iosInfo;
    return ios.name;                     // iOS doesn't return manufacturer directly
  }

  return null;
}
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(ConnectivityController(), permanent: true);
    // Make API service persistent
    Get.put<ApiService>(ApiService(), permanent: true);

    // AuthService requires async init
    Get.putAsync<AuthService>(() async => await AuthService().init());
    Get.putAsync<HomeService>(() async => await HomeService().init());
  }
}