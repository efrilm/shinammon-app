import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';

class InformationFeeCard extends StatelessWidget {
  final String feeReservation;
  final String? feeBooking;
  final String? total;

  const InformationFeeCard(
      {Key? key, required this.feeReservation, this.feeBooking, this.total})
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
            height: 70,
          ),
          Container(
            width: 285,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                HeaderCard(
                  text: "INFORMASI BIAYA",
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reservasi',
                      style: blackTextStyle,
                    ),
                    Text(
                      "IDR $feeReservation",
                      style: blueTextStyle,
                    ),
                  ],
                ),
                feeBooking != null
                    ? Column(
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking",
                                style: blackTextStyle,
                              ),
                              Text(
                                "IDR $feeBooking",
                                style: blueTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                total != null
                    ? Column(
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: blackTextStyle,
                              ),
                              Text(
                                "IDR $total",
                                style: blueTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
