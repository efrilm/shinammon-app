import 'package:flutter/material.dart';
import 'package:shinnamon/pages/sales_page/utils_lead/booking_page.dart';
import 'package:shinnamon/pages/sales_page/utils_lead/follow_up_page.dart';
import 'package:shinnamon/pages/sales_page/utils_lead/new_lead_page.dart';
import 'package:shinnamon/pages/sales_page/utils_lead/reservasi_page.dart';
import 'package:shinnamon/thema.dart';

class SLeadPage extends StatelessWidget {
  const SLeadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Lead',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: kPrimaryColor,
          tabs: [
            Tab(
              child: Text(
                'Lead Baru',
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                'Follow Up',
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                'Reservasi',
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                'Booking',
                style: blackTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: header(),
        body: TabBarView(
          children: [
            SNewLeadPage(),
            SFollowUpPage(),
            SReservasiPage(),
            SBookingPage(),
          ],
        ),
      ),
    );
  }
}
