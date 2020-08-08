import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/util/styles.dart';
import 'package:shopping_list/util/ui_helpers.dart';

class ChooseLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              verticalSpaceSmall,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _LanguageTile(
                      id: "tr",
                      name: "Türkçe",
                      description: "Dil Seçiniz",
                      buttonLabel: "Seç",
                      color: FIRST_COLOR,
                    ),
                    _LanguageTile(
                      id: "en",
                      name: "English",
                      description: "Choose Language",
                      buttonLabel: "Choose",
                      color: SECOND_COLOR,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String buttonLabel;
  final Color color;

  const _LanguageTile(
      {Key key,
      this.name,
      this.buttonLabel,
      this.description,
      this.color,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            verticalSpaceMedium,
            Container(
              height: SizeConfig.blockSizeVertical * 10,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            verticalSpaceMedium,
            Text(
              name,
              style: TextStyle(
                  color: darkerText, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () async {
                  bool success = await LocalStorageRepository.setLanguage(id);
                  if (!success) {
                    Get.rawSnackbar(
                      message: "Bir sorun oluştu",
                      isDismissible: true,
                      duration: Duration(seconds: 1),
                    );
                    return;
                  }
                  Get.updateLocale(Locale(id));
                  Get.offAndToNamed("/Choose");

                },
                child: Text(
                  buttonLabel,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
