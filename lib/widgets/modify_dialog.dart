import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/provider/id_controller.dart';
import 'package:shopping_list/provider/urgency_controller.dart';
import 'package:shopping_list/repository/firestore_repository.dart';
import 'package:shopping_list/util/ui_helpers.dart';
import 'package:shopping_list/widgets/custom_elevated_button.dart';
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
      title: Text(
        "modify_item".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: const Color(0xff4b515c), fontWeight: FontWeight.w700, fontSize: 19),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
        width: SizeConfig.blockSizeHorizontal * 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: const Color(0x59abb4bd), width: 0.5),
                  boxShadow: [BoxShadow(color: const Color(0x10000000), offset: Offset(0, 5), blurRadius: 25, spreadRadius: 0)],
                  color: const Color(0xffffffff)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: const Color(0xffb5c1c9), fontWeight: FontWeight.w400, fontSize: 17),
                      hintText: " " + "Name".tr,
                      border: InputBorder.none),
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
            ),
            SizeConfig.verticalSpace(3),
            UrgencyList(),
            SizeConfig.verticalSpace(1),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel".tr,
            style: TextStyle(color: Color(0xff4b515c), fontWeight: FontWeight.w500),
          ),
        ),
        CElevatedButton(
          titleWidget: loading
              ? CircularProgressIndicator()
              : Text(
                  "Modify".tr,
                  style: TextStyle(color: Colors.white),
                ),
          color: Theme.of(context).primaryColor,
          onPressed: loading
              ? null
              : () async {
                  String name = _nameController.text;
                  Urgency urgency = Get.find<UrgencyController>().urgency;

                  if (_nameController.text.isEmpty || _nameController.text.length < 1) {
                    Get.rawSnackbar(message: 'invalid_name'.tr, duration: Duration(seconds: 2), isDismissible: true);
                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  String listId = controller.id;

                  FirestoreRepository.updateItem(listId, widget.item.id, name, urgency);

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
