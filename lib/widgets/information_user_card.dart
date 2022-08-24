import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';

class InformationUserCard extends StatelessWidget {
  final String salesName;
  final String markomName;
  const InformationUserCard(
      {Key? key, required this.salesName, required this.markomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: hMargin,
        right: hMargin,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(dRadius),
        boxShadow: [shadow],
      ),
      child: Row(
        children: [
          DividerVertical(
            height: 80,
          ),
          Container(
            width: 285,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                HeaderCard(text: "INFORMASI PENGGUNA"),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sales",
                      style: blackTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        salesName,
                        style: blueTextStyle.copyWith(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Markom",
                      style: blackTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        markomName,
                        style: blueTextStyle.copyWith(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
