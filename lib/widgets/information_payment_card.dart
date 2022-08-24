import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';

class InformationPaymentCard extends StatelessWidget {
  final String price;
  final String discountPrice;
  final String downpayment;
  final String discountDownpayment;
  final String downpaymentPaid;
  final String subtotal;

  const InformationPaymentCard({
    Key? key,
    required this.price,
    required this.discountPrice,
    required this.downpayment,
    required this.discountDownpayment,
    required this.downpaymentPaid,
    required this.subtotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: hMargin,
        right: hMargin,
        top: 20,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [shadow],
        borderRadius: BorderRadius.circular(dRadius),
      ),
      child: Column(
        children: [
          Row(
            children: [
              DividerVertical(
                height: 150,
              ),
              Container(
                width: 285,
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    HeaderCard(
                      text: "INFORMASI PEMBAYARAN",
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harga',
                          style: blackTextStyle,
                        ),
                        Text(
                          'IDR $price',
                          style: blueTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diskon Harga',
                          style: blackTextStyle,
                        ),
                        Text(
                          'IDR $discountPrice',
                          style: blueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uang Muka',
                          style: blackTextStyle,
                        ),
                        Text(
                          'IDR $downpayment',
                          style: blueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diskon Uang Muka',
                          style: blackTextStyle,
                        ),
                        Text(
                          'IDR $discountDownpayment',
                          style: blueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uang Muka di Bayar',
                          style: blackTextStyle,
                        ),
                        Text(
                          'IDR $downpaymentPaid',
                          style: blueTextStyle,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(dRadius),
                      ),
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "IDR $subtotal",
                            style: blueTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
