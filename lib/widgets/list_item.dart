import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/urgency.dart';
import 'modify_dialog.dart';

class ListItem extends StatelessWidget {

  final Item item;

  ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Clicked Item -> $item}");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ModifyDialog(Scaffold.of(context),item));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFa8aaad).withOpacity(0.8),
              Color(0xFFa8aaad).withOpacity(0.3),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp
          ),
          border: Border.all(
            color: Colors.grey,

          ),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.symmetric(
            vertical: 8, horizontal: 4),
        padding: EdgeInsets.all(3),
        child: ListTile(
          title: Text(
            "${item.name}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: CircleAvatar(
          backgroundColor: item.urgency.color,
          ),
        ),
      ),
    );
  }
}
