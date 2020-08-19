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
              builder: (_) => ModifyDialog(Scaffold.of(context), item));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          padding: EdgeInsets.all(3),
          child: Container(
            child: Row(
              children: [
                Text(
                  "${index + 1}.",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                horizontalSpaceSmall,
                Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Spacer(),
                Text(
                  item.urgency.name,
                  style: TextStyle(
                    color: item.urgency.color,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                horizontalSpaceMedium,
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
