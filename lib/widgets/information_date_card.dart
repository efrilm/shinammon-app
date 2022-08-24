import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';

import 'header_card.dart';

class InformationDateCard extends StatelessWidget {
  final String? dateAdd;
  final String? dateFollowUp;
  final String? dateWillVisited;
  final String? dateAlreadyVisited;
  final String? dateReservation;
  final String? dateBooking;
  final String? dateSold;

  const InformationDateCard(
      {Key? key,
      this.dateAdd,
      this.dateFollowUp,
      this.dateWillVisited,
      this.dateAlreadyVisited,
      this.dateReservation,
      this.dateBooking,
      this.dateSold})
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
            height: 120,
          ),
          Container(
            width: 285,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderCard(
                  text: "INFORMASI TANGGAL",
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Masuk",
                      style: blackTextStyle,
                    ),
                    Text(
                      dateAdd!,
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
                      "Follow Up",
                      style: blackTextStyle,
                    ),
                    Text(
                      dateFollowUp!,
                      style: blackTextStyle,
                    ),
                  ],
                ),
                dateWillVisited != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akan Visit",
                                style: blackTextStyle,
                              ),
                              Text(
                                dateWillVisited!,
                                style: blackTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                dateAlreadyVisited != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sudah Visit",
                                style: blackTextStyle,
                              ),
                              Text(
                                dateAlreadyVisited!,
                                style: blackTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                dateReservation != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Reservasi",
                                style: blackTextStyle,
                              ),
                              Text(
                                dateReservation!,
                                style: blackTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                dateBooking != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking",
                                style: blackTextStyle,
                              ),
                              Text(
                                dateBooking!,
                                style: blackTextStyle,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                dateSold != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Penjualan",
                                style: blackTextStyle,
                              ),
                              Text(
                                dateSold!,
                                style: blackTextStyle,
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
