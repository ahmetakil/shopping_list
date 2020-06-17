import 'package:flutter/material.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/widgets/urgency_box.dart';

class UrgencyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aciliyet: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [for (Urgency u in Urgency.values) UrgencyBox(u)],
          ),
        ],
      ),
    );
  }
}
