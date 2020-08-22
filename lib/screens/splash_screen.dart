import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/screens/list_screen.dart';
import 'package:shopping_list/util/ui_helpers.dart';

import 'settings_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> checkListId() async {

    await LocalStorageRepository.initialize();

    if (!LocalStorageRepository.hasLanguage()) {
      return Future.delayed(Duration(seconds: 1), () => SettingsScreen());
    }

    String localeId = LocalStorageRepository.getLanguage();
    Get.updateLocale(Locale(localeId));

    if (!LocalStorageRepository.hasListId()) {
      return Future.delayed(Duration(seconds: 1), () => HomeScreen());
    }

    String listId = LocalStorageRepository.getListId();
    Get.find<IdController>().setId(listId);
    return Future.delayed(Duration(seconds: 1), () => ListScreen());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Splash(
      navigateAfterFuture: () => checkListId(),
      backgroundColor: Colors.blueAccent,
      loaderColor: Colors.orangeAccent,
      title: Text(
        "Shopping List",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
