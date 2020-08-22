import 'package:flutter/material.dart';
import 'package:shopping_list/util/styles.dart';
import 'package:shopping_list/util/ui_helpers.dart';

import '../models/item.dart';
import '../models/urgency.dart';
import 'modify_dialog.dart';

class ListItem extends StatelessWidget {
  final Item item;
  final int index;
  final Function delete;

  ListItem({this.item, this.index, this.delete});

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
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.all(color: const Color(0x59abb4bd), width: 2),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  horizontalSpaceTiny,
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: item.urgency.color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.delete, color: RED), onPressed: delete)
                ],
              ),
            ),
          ),
        ));
  }
}
