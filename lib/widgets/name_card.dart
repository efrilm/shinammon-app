import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class NameCard extends StatelessWidget {
  final String text;
  final String subText;
  final Function() onTap;

  const NameCard({
    Key? key,
    required this.text,
    required this.subText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: blackTextStyle.copyWith(),
              ),
              Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  subText,
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: kGreyColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 2,
            width: double.infinity,
            color: kGreyLightColor,
          ),
        ],
      ),
    );
  }
}
