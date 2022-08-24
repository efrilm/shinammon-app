import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class DividerVertical extends StatelessWidget {
  final double height;
  const DividerVertical({
    Key? key,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: height,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(dRadius),
      ),
    );
  }
}
