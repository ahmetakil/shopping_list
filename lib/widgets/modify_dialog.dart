import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/provider/urgency_controller.dart';
import 'package:shopping_list/repository/firestore_repository.dart';
import 'package:shopping_list/widgets/urgency_list.dart';

class ModifyDialog extends StatefulWidget {
  final Item item;

  ModifyDialog(this.item);

  @override
  _ModifyDialogState createState() => _ModifyDialogState();
}

class _ModifyDialogState extends State<ModifyDialog> {
  final TextEditingController _nameController = TextEditingController();
  IdController controller;
  bool loading = false;

  @override
  void initState() {
    _nameController.text = widget.item.name;
    controller = Get.find<IdController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("modify_item".tr),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name".tr,
              ),
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
            UrgencyList(),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel".tr),
        ),
        RaisedButton(
          child: loading ? CircularProgressIndicator() : Text("Modify".tr),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: loading
              ? null
              : () async {
                  String name = _nameController.text;
                  Urgency urgency = Get.find<UrgencyController>().urgency;


                  if (_nameController.text.isEmpty ||
                      _nameController.text.length < 1) {
                    Get.rawSnackbar(
                      message: 'invalid_name'.tr,
                      duration: Duration(seconds: 2),
                      isDismissible: true
                    );
                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  String listId = controller.id;

                  FirestoreRepository.updateItem(
                      listId, widget.item.id, name, urgency);

                  setState(() {
                    loading = false;
                  });
                  Navigator.of(context).pop();
                },
        )
      ],
    );
  }
}
