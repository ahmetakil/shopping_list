import 'package:flutter/material.dart';
import 'package:shopping_list/util/ui_helpers.dart';

import '../models/item.dart';
import '../models/urgency.dart';
import 'modify_dialog.dart';

class ListItem extends StatelessWidget {
  final Item item;
  final int index;

  ListItem(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ModifyDialog(item));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.all(color: const Color(0x59abb4bd), width: 0.5),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x10000000),
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    spreadRadius: 0)
              ],
              color: const Color(0xffffffff),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: item.urgency.color,
                    radius: 16,
                  ),
                  horizontalSpaceSmall,
                  Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
