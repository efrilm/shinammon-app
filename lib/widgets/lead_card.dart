import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';

class LeadCard extends StatelessWidget {
  final String name;
  final String date;
  final String noHome;
  final String paymentType;
  final bool isPayment;
  final bool isHome;
  final Function() onTap;

  const LeadCard({
    Key? key,
    required this.name,
    required this.date,
    this.noHome = '',
    this.paymentType = '',
    this.isPayment = false,
    this.isHome = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 12,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [
            shadow,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DividerVertical(),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    isPayment == true
                        ? SizedBox(
                            height: 6,
                          )
                        : SizedBox(),
                    isPayment == true
                        ? Text(
                            paymentType,
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      date,
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isHome == true
                ? Container(
                    width: 33,
                    height: 23,
                    margin: EdgeInsets.only(
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      color: kBlueColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        noHome,
                        style: whiteTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
