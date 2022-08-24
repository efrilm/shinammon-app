import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class DetailSales extends StatelessWidget {
  const DetailSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Detail Sales",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        elevation: 1,
        backgroundColor: kWhiteColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget profil() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dRadius),
                color: kGreyColor,
                image: DecorationImage(
                  image: AssetImage('assets/sales1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Christion Jimbran",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget cardCount() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: dRadius,
          right: dRadius,
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
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "5",
                  style: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "Reservasi",
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
                  "12",
                  style: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Booking',
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
                  "8",
                  style: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  'Sold',
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

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: ListView(
          children: [
            profil(),
            cardCount(),
          ],
        ),
      ),
    );
  }
}
