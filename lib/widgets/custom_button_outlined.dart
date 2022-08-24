import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class CustomButtonOutlined extends StatelessWidget {
  final String text;
  final double width;
  final Function() onTap;
  const CustomButtonOutlined({
    Key? key,
    required this.text,
    this.width = double.infinity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(dRadius),
        border: Border.all(
          width: 2,
          color: kPrimaryColor,
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
