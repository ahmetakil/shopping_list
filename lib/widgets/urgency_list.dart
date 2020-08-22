import 'package:flutter/material.dart';
import 'package:shopping_list/models/urgency.dart';
import 'package:shopping_list/widgets/urgency_box.dart';
import 'package:get/get.dart';

class UrgencyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Urgency".tr + ": ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [for (Urgency u in Urgency.values) UrgencyBox(u)],
            ),
          ),
        ],
      ),
    );
  }
}
