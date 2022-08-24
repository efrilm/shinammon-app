import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class CountStockCard extends StatelessWidget {
  final String number;
  final String title;
  const CountStockCard({Key? key, required this.number, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(dRadius),
            boxShadow: [shadow],
          ),
          child: Center(
            child: Text(
              number,
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          title,
          style: greyTextStyle.copyWith(
            fontWeight: medium,
          ),
        )
      ],
    );
  }
}
