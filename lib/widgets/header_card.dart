import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class HeaderCard extends StatelessWidget {
  final String text;
  const HeaderCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: primaryTextStyle.copyWith(
            fontWeight: light,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          height: 1,
          width: 285,
          decoration: BoxDecoration(
            color: kGreyLightColor,
          ),
        ),
      ],
    );
  }
}
