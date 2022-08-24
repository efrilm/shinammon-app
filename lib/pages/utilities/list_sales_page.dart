import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/sales_card.dart';

class ListSales extends StatelessWidget {
  const ListSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          "Daftar Sales",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
        padding: EdgeInsets.symmetric(
          horizontal: hMargin,
        ),
        children: [
          SalesCard(
            onTap: () {},
            name: "Eriska",
            joinDate: "16 Apr 2022",
            imageUrl: "assets/sales1.jpg",
          ),
          SalesCard(
            onTap: () {},
            name: "Eriska",
            joinDate: "16 Apr 2022",
            imageUrl: "assets/sales1.jpg",
          ),
          SalesCard(
            onTap: () {},
            name: "Eriska",
            joinDate: "16 Apr 2022",
            imageUrl: "assets/sales1.jpg",
          ),
          SalesCard(
            onTap: () {},
            name: "Eriska",
            joinDate: "16 Apr 2022",
            imageUrl: "assets/sales1.jpg",
          ),
        ],
      ),
    );
  }
}
