import 'package:flutter/material.dart';
import 'package:shinnamon/pages/markom/utils_visit/already_visit_page.dart';
import 'package:shinnamon/pages/markom/utils_visit/will_visit_page.dart';
import 'package:shinnamon/thema.dart';

class MVisitPage extends StatelessWidget {
  const MVisitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Datang",
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
                "Akan Datang",
                style: blackTextStyle,
              ),
            ),
            Tab(
              child: Text(
                "Sudah Datang",
                style: blackTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: header(),
        body: TabBarView(
          children: [
            MWillVisitPage(),
            MAlreadyVisitPage(),
          ],
        ),
      ),
    );
  }
}
