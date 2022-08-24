import 'package:flutter/material.dart';
import 'package:shinnamon/pages/insight/all_lead/all_day_page.dart';
import 'package:shinnamon/pages/insight/all_lead/all_month_page.dart';
import 'package:shinnamon/pages/insight/all_lead/all_week_page.dart';
import 'package:shinnamon/thema.dart';

class AllLeadPage extends StatelessWidget {
  const AllLeadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Semua Lead",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        bottom: TabBar(
          indicatorColor: kPrimaryColor,
          tabs: [
            Tab(
              child: Text(
                "Harian",
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                "Mingguan",
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                "Bulanan",
                style: blackTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: header(),
        body: TabBarView(
          children: [
            AllDayPage(),
            AllWeekPage(),
            AllMonthPage(),
          ],
        ),
      ),
    );
  }
}
