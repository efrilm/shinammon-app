import 'package:flutter/material.dart';
import 'package:shinnamon/pages/insight/users/sales_day_page.dart';
import 'package:shinnamon/pages/insight/users/sales_month_page.dart';
import 'package:shinnamon/pages/insight/users/sales_week_page.dart';
import 'package:shinnamon/thema.dart';

class MainSalesPage extends StatefulWidget {
  final String userId;
  MainSalesPage(this.userId);

  @override
  _MainSalesPageState createState() => _MainSalesPageState();
}

class _MainSalesPageState extends State<MainSalesPage> {
  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Sales",
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
            SalesDayPage(widget.userId),
            SalesWeekPage(widget.userId),
            SalesMonthPage(widget.userId)
          ],
        ),
      ),
    );
  }
}
