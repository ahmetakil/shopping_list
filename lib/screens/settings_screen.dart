import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/util/styles.dart';
import 'package:shopping_list/util/ui_helpers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedId = "";

  void updateSelected(String id) {
    setState(() {
      selectedId = id;
    });
  }

  bool isSelected(id) {
    return selectedId == id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: WHITE,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Shopping ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "List: ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                              text: "Settings".tr,
                              style: TextStyle(
                                color: ORANGE,
                              )),
                        ]),
                  ),
                ],
              ),
              Divider(
                color: GREEN,
                thickness: 4,
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Text(
                    "Change Language".tr + ":",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              Column(
                children: [
                  _LanguageTile(
                    id: "tr",
                    name: "Türkçe",
                    update: updateSelected,
                    isSelected: isSelected,
                  ),
                  verticalSpaceMedium,
                  _LanguageTile(
                    id: "en",
                    name: "English",
                    update: updateSelected,
                    isSelected: isSelected,
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: GOLD,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Save'.tr,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    bool success = await LocalStorageRepository.setLanguage(selectedId);
                    if (!success) {
                      Get.rawSnackbar(
                        message: "Bir sorun oluştu",
                        isDismissible: true,
                        duration: Duration(seconds: 1),
                      );
                      return;
                    }
                    Get.updateLocale(Locale(selectedId));
                    Get.off(HomeScreen());
                  },
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
  final Function update;
  final Function isSelected;

  const _LanguageTile({Key key, this.name, this.description, this.id, this.update, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        update(id);
        Get.updateLocale(Locale(id));
      },
      child: Text(
        name,
        style: isSelected(id)
            ? TextStyle(
                color: ORANGE,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )
            : TextStyle(
                color: darkerText,
                fontSize: 22,
              ),
      ),
    ));
  }
}
