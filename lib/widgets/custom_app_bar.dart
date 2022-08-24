import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final Widget? action;

  const CustomAppBar({Key? key, required this.text, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: hMargin,
        right: hMargin,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 20,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
          Container(
            child: action,
          ),
        ],
      ),
    );
  }
}
