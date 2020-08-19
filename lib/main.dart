import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/screens/choose_language_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'home_page.dart';

void main() => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        defaultTransition: Transition.native,
        theme: ThemeData(
          fontFamily: "OpenSans"
        ),
        translations: MyTranslations(),
        locale: Locale('en'),
        getPages: [
          GetPage(
            name: '/',
            page: () => HomePage(),
          ),
          GetPage(name: "/ChooseLanguage", page: () => ChooseLanguage()),
          GetPage(name: "/HomeScreen", page: () => HomeScreen()),
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
      'add_new_item': 'Add new Item',
      'empty_screen': 'Your list is Empty! Start adding items',
      'invalid_name': 'Please enter a valid item name',
      'modify_item': 'Modify Item',
      'Urgency.AZ': 'Low',
      'Urgency.ORTA': 'Medium',
      'Urgency.COK': 'Urgent'
    },
    'tr': {
      'title': 'Hoşgeldiniz',
      'create_list': 'Yeni liste Yarat',
      'join_list': 'Listeye Katıl',
      'add_new_item': 'Yeni Eşya Ekle',
      'empty_screen': 'Listeniz boş, eşya ekleyin',
      'invalid_name': "Lütfen Geçerli Bir İsim Girin",
      'modify_item': 'Ürünü GÜncelle',
      'Urgency.AZ': 'Az',
      'Urgency.ORTA': 'Orta',
      'Urgency.COK': 'Acil'
    }
  };
}