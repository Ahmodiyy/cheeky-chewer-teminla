import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utilities/constants.dart';

class HighkonButton extends StatelessWidget {
  final IconData iconData;
  final Function clickFunction;
  final double iconContainerSize;
  final Color iconBackgroundColor;
  final Color iconColor;
  const HighkonButton({
    required this.iconData,
    required this.clickFunction,
    this.iconContainerSize = 36,
    this.iconBackgroundColor = Colors.white,
    this.iconColor = constantActionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconContainerSize,
      width: iconContainerSize,
      decoration: ShapeDecoration(
        color: iconBackgroundColor,
        shape: CircleBorder(
          side: BorderSide(
            width: 2.0,
            color: constantActionColor,
          ),
        ),
      ),
      child: IconButton(
        color: constantActionColor,
        onPressed: () {
          clickFunction();
        },
        icon: Icon(
          iconData,
          color: iconColor,
        ),
        iconSize: iconContainerSize / 2,
      ),
    );
  }
}
