import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';

class TrackingCard extends StatelessWidget {
  final String userName;
  final String note;
  final String date;
  final String trackingId;

  const TrackingCard({
    Key? key,
    required this.userName,
    required this.note,
    required this.date,
    required this.trackingId,
  }) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderCard(text: userName),
                SizedBox(height: 12),
                Container(
                  child: Text(
                    note,
                    style: blackTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: greyTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "#" + trackingId,
                      style: greyTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
