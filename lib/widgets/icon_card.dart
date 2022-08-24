import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class IconCard extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final double height;
  final double width;
  final double iconSize;
  final Color? color;

  const IconCard({
    Key? key,
    required this.icon,
    required this.onTap,
    this.height = 40,
    this.width = 40,
    this.iconSize = 24,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color == null ? kPrimaryColor.withOpacity(0.5) : color,
          borderRadius: BorderRadius.circular(dRadius),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
