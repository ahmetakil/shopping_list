import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/screens/settings_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/util/styles.dart';
import 'home_page.dart';

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri uri) async {
  print('backgroundCallback XXX B1 uri: $uri');
  if (uri.host == 'updatecounter') {
    print('backgroundCallback XXX B2 INSIDE');
    int _counter;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0).then((value) {
      _counter = value;
      _counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(name: 'ShoppingListWidget', iOSName: 'AppWidgetProvider');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HomeWidget.registerBackgroundCallback(backgroundCallback);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      defaultTransition: Transition.native,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: GOLD,
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
          'Urgency': 'Priority',
          'Urgency.AZ': 'Low',
          'Urgency.ORTA': 'Medium',
          'Urgency.COK': 'High',
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
          'modify_item': 'Ürünü Güncelle',
          'Urgency': 'Aciliyet',
          'Urgency.AZ': 'Az',
          'Urgency.ORTA': 'Orta',
          'Urgency.COK': 'Acil',
          'Name': 'İsim',
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
    1. Allow for removal of lists from home page. [X]
    2. Implement local notifications.
    3. Implement firebase auth.
    4. Share button
    5. Sort items respect to urgency [X]




 */
