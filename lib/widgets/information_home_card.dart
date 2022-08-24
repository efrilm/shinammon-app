import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';

class InformationHomeCard extends StatelessWidget {
  final String noHome;
  final String typeHome;
  final String typePayment;

  const InformationHomeCard(
      {Key? key,
      required this.noHome,
      required this.typeHome,
      required this.typePayment})
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
                HeaderCard(
                  text: "INFORMASI RUMAH",
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No. Rumah",
                      style: blackTextStyle,
                    ),
                    Text(
                      noHome,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tipe Rumah",
                      style: blackTextStyle,
                    ),
                    Text(
                      typeHome,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cara Pembayaran",
                      style: blackTextStyle,
                    ),
                    Text(
                      typePayment,
                      style: blueTextStyle,
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
