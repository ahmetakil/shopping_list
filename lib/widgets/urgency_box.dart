import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/provider/urgency_provider.dart';

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
    final urgencyProvider = Provider.of<UrgencyProvider>(context);

    return InkWell(
      onTap: () {
        Provider.of<UrgencyProvider>(context, listen: false)
            .setUrgency(widget.urgency);
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
          Text(
            widget.urgency.value,
            style: urgencyProvider.isSelectedUrgency(widget.urgency)
                ? TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold)
                : TextStyle(),
          )
        ],
      ),
    );
  }
}
