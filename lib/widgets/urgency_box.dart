import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/provider/urgency_controller.dart';
import 'package:shopping_list/util/styles.dart';

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
            height: 40,
            width: 32,
            decoration: BoxDecoration(
              color: widget.urgency.color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GetBuilder<UrgencyController>(
            init: UrgencyController(),
            builder: (UrgencyController controller) => Text(
              widget.urgency.toString().tr,
              textAlign: TextAlign.right,
              style: controller.isSelectedUrgency(widget.urgency)
                  ? TextStyle(
                      color: GOLD,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 18)
                  : TextStyle(
                      color: const Color(0xff4b515c),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
