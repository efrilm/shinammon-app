import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double width;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: color == null ? kPrimaryColor : color,
        borderRadius: BorderRadius.circular(dRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
