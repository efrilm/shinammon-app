import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class VisitDateCard extends StatelessWidget {

  final String date;

  const VisitDateCard({
    Key? key, required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        left: hMargin,
        right: hMargin,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(dRadius),
        boxShadow: [shadow],
      ),
      child: Column(
        children: [
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tanggal Datang',
                  style: blackTextStyle,
                ),
                Text(
                  date,
                  style: blackTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
