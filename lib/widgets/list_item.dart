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
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: EdgeInsets.all(3),
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: item.urgency.color,
                ),
                horizontalSpaceSmall,
                Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}

/*
ListTile(
          title: Text(
            "${item.name}",
            style: TextStyle(
                ),
          ),

        ),
      ),
 */
