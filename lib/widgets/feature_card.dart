import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(dRadius),
              boxShadow: [
                shadow,
              ],
            ),
            child: Icon(
              icon,
              color: kPrimaryColor,
              size: 26,
            ),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: primaryTextStyle.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
