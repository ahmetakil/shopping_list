import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/urgency_controller.dart';

import '../models/urgency.dart';

class UrgencyBox extends StatefulWidget {
  final Urgency urgency;

  UrgencyBox(this.urgency);

  @override
  _UrgencyBoxState createState() => _UrgencyBoxState();
}

class _UrgencyBoxState extends State<UrgencyBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Get.find<UrgencyController>().setUrgency(widget.urgency);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.urgency.color,
              borderRadius: BorderRadius.circular(6),
            ),
            width: 40,
            height: 40,
          ),
          SizedBox(
            height: 5,
          ),
          GetBuilder<UrgencyController>(
            init: UrgencyController(),
            builder: (UrgencyController controller) => Text(
              widget.urgency.value,
              style: controller.isSelectedUrgency(widget.urgency)
                  ? TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)
                  : TextStyle(),
            ),
          )
        ],
      ),
    );
  }
}
