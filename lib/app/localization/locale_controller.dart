import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  final Rx<Locale> locale = const Locale('ar').obs;

  void switchToArabic() {
    _setLocale(const Locale('ar'));
  }

  void switchToEnglish() {
    _setLocale(const Locale('en'));
  }

  void toggleLocale() {
    if (locale.value.languageCode == 'ar') {
      switchToEnglish();
    } else {
      switchToArabic();
    }
  }

  void _setLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }
}
