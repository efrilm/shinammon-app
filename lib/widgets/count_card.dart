import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class CountCard extends StatelessWidget {
  final String countOfDaily;
  final String countOfWeekly;
  final String countOfMonthly;

  const CountCard({
    Key? key,
    required this.countOfDaily,
    required this.countOfWeekly,
    required this.countOfMonthly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 40,
        left: hMargin,
        right: hMargin,
      ),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(dRadius),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: kBlackColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                countOfDaily,
                style: primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Harian',
                style: greyTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(
              color: kGreyLightColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                countOfWeekly,
                style: primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Mingguan',
                style: greyTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(
              color: kGreyLightColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                countOfMonthly,
                style: primaryTextStyle.copyWith(
                  fontSize: 22,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                'Bulanan',
                style: greyTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
