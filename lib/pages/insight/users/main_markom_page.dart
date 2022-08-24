import 'package:flutter/material.dart';
import 'package:shinnamon/pages/insight/users/markom_day_page.dart';
import 'package:shinnamon/pages/insight/users/markom_month_page.dart';
import 'package:shinnamon/pages/insight/users/markom_week_page.dart';
import 'package:shinnamon/thema.dart';

class MainMarkomPage extends StatefulWidget {
  final String userId;
  MainMarkomPage(this.userId);

  @override
  _MainMarkomPageState createState() => _MainMarkomPageState();
}

class _MainMarkomPageState extends State<MainMarkomPage> {
  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Markom",
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
            MarkomDayPage(widget.userId),
            MarkomWeekPage(widget.userId),
            MarkomMonthPage(widget.userId)
          ],
        ),
      ),
    );
  }
}
