import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/custom_button_outlined.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';
import 'package:shinnamon/widgets/information_fee_card.dart';
import 'package:shinnamon/widgets/information_home_card.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/note_card.dart';

class DetailSalesRequestPage extends StatelessWidget {
  const DetailSalesRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          "Karin Novilda",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, color: kPrimaryColor),
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
          bottom: 100,
        ),
        child: Column(
          children: [
            CustomButton(
              onPressed: () {},
              text: "Terima",
            ),
            SizedBox(
              height: 20,
            ),
            CustomButtonOutlined(
              text: 'Tidak di Terima',
              onTap: () {},
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          InformationLeadCard(
            name: 'Karin Novilda',
            noWhatsapp: '16 Apr 2022 16',
            source: "Iklan Pribadi ",
            date: "16 APr 2022",
          ),
          NoteCard(
            text: "Minta Dimasukkan",
          ),
          InformationHomeCard(
            noHome: "16 Apr 2022",
            typeHome: "100/200",
            typePayment: "Cash Betahap",
          ),
          InformationFeeCard(feeReservation: "5000000"),
          Container(
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
                        text: "PERMINTAAN DARI",
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(dRadius),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/sales2.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Hanggini Satro ',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          button(),
        ],
      ),
    );
  }
}
