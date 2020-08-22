import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/repository/firestore_repository.dart';
import 'package:shopping_list/repository/local_storage_repository.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/screens/list_screen.dart';

class JoinDialog extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final IdController controller = Get.put(IdController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text("Enter List ID".tr),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: "List ID",
              ),
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Cancel".tr,
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        RaisedButton(
          color: Colors.green,
          child: Text("Submit".tr),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onPressed: () async {
            final String givenId = _idController.text;

            if (!await FirestoreRepository.canFetchList(givenId)) {
              Get.rawSnackbar(
                message: "invalid_id".tr,
                isDismissible: true,
                duration: Duration(seconds: 1),
              );
              return;
            }

            controller.setId(givenId);

            LocalStorageRepository.setListId(givenId);
            Get.back();
            Get.to(ListScreen());
          },
        )
      ],
    );
  }
}
