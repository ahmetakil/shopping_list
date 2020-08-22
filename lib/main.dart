import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/screens/settings_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'home_page.dart';

void main() {
  runApp(
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
          GetPage(name: "/ChooseLanguage", page: () => SettingsScreen()),
          GetPage(name: "/HomeScreen", page: () => HomeScreen()),
        ],
      ),
    );
  Get.put<IdController>(IdController());
}

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
      'Urgency.COK': 'Urgent',
      'Name': 'Name',
      "already_exists": "An item with this name already exists in the list",
      "invalid_id": "Please enter a valid ID.",
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
      'Urgency.COK': 'Acil',
      'Name': 'Isım',
      "Your": "Senin",
      "Lists": "Listelerin",
      "Add": "Ekle",
      "Add Item": "Ürün Ekle",
      "Cancel": "İptal",
      "already_exists": "Bu isimde bir ürün zaten mevcut!",
      "Modify": "Güncelle",
      "Save": "Kaydet",
      "Change Language": "Dil Değiştir",
      "Settings": "Ayarlar",
      "Enter List ID": "Liste ID'nizi Girin.",
      "invalid_id": "Lütfen geçerli bir ID Girin.",
      "Submit": "Katıl",
    }
  };
}

/*
  TODO:
    1. Allow for removal of lists from home page.
    2. Implement local notifications.
    3. Implement firebase auth.



 */