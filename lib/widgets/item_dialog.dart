import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/urgency_controller.dart';
import 'package:shopping_list/repository/firestore_repository.dart';
import 'package:shopping_list/widgets/urgency_list.dart';

import '../models/urgency.dart';

class ItemDialog extends StatefulWidget {
  final String id;

  ItemDialog(this.id);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add Item".tr,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
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
          child: loading ? CircularProgressIndicator() : Text("Add".tr),
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
                      message: "invalid_name".tr,
                      duration: Duration(seconds: 2),
                    );
                    return;
                  }

                  if (await FirestoreRepository.doesItemExists(
                      widget.id, name)) {
                    Get.rawSnackbar(
                      message: "already_exists".tr,
                      duration: Duration(seconds: 2),
                    );

                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  FirestoreRepository.addNewItem(widget.id, name, urgency);
                  setState(() {
                    loading = false;
                  });
                  _nameController.clear();
                  Navigator.of(context).pop();
                },
        )
      ],
    );
  }
}
