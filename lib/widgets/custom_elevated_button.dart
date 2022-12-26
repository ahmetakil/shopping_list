import 'package:flutter/material.dart';
import 'package:shopping_list/util/styles.dart';

class CElevatedButton extends StatelessWidget {
  final String title;
  final Widget titleWidget;
  final VoidCallback onPressed;
  final Color color;

  const CElevatedButton({Key key, this.title, this.onPressed, this.color, this.titleWidget})
      : assert(title != null || titleWidget != null, ""),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: color ?? GOLD,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: titleWidget ??
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
      onPressed: onPressed,
    );
  }
}
