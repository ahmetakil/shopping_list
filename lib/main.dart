import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/screens/choose_language_screen.dart';
import 'package:shopping_list/screens/choose_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'home_page.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        defaultTransition: Transition.native,
        translations: MyTranslations(),
        locale: Locale('en'),
        getPages: [
          GetPage(
            name: '/',
            page: () => HomePage(),
          ),
          GetPage(name: "/ChooseLanguage", page: () => ChooseLanguage()),
          GetPage(name: "/Choose", page: () => ChooseScreen()),
          GetPage(name: "/List", page: () => ListScreen()),
        ],
      ),
    );

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': 'Welcome',
      'create_list': 'Create a List',
      'join_list': 'Join a List',
    },
    'tr': {
      'title': 'Hoşgeldiniz',
      'create_list': 'Yeni liste Yarat',
      'join_list': 'Listeye Katıl'
    }
  };
}