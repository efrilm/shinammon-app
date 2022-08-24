import 'package:flutter/material.dart';
import 'package:shinnamon/pages/utilities/detail_sales_request_page.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/request_card.dart';

class SalesRequestPage extends StatelessWidget {
  const SalesRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          'Permintaan Sales',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          RequestCard(
            onTapDetail: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailSalesRequestPage(),
                ),
              );
            },
            name: "Leandri Sitopung hah",
            date: "16 Apr 2022 18:00:00",
            source: "Iklan Pribadi",
            note: "Minta Dimasukkan  Minta Dimasukkan  Minta Dimasukkan  ",
            onAccept: () {},
            imageUrl: "assets/sales1.jpg",
          ),
          RequestCard(
            onTapDetail: () {},
            name: "Leandri Sitopung hah",
            date: "16 Apr 2022 18:00:00",
            source: "Iklan Pribadi",
            note: "Minta Dimasukkan  Minta Dimasukkan  Minta Dimasukkan  ",
            onAccept: () {},
            imageUrl: "assets/sales1.jpg",
          ),
          RequestCard(
            onTapDetail: () {},
            name: "Leandri Sitopung hah",
            date: "16 Apr 2022 18:00:00",
            source: "Iklan Pribadi",
            note: "Minta Dimasukkan  Minta Dimasukkan  Minta Dimasukkan  ",
            onAccept: () {},
            imageUrl: "assets/sales1.jpg",
          ),
          RequestCard(
            onTapDetail: () {},
            name: "Leandri Sitopung hah",
            date: "16 Apr 2022 18:00:00",
            source: "Iklan Pribadi",
            note: "Minta Dimasukkan  Minta Dimasukkan  Minta Dimasukkan  ",
            onAccept: () {},
            imageUrl: "assets/sales1.jpg",
          ),
        ],
      ),
    );
  }
}
