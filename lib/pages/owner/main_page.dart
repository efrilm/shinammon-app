import 'package:flutter/material.dart';
import 'package:shinnamon/pages/owner/account_page.dart';
import 'package:shinnamon/pages/owner/home_page.dart';
import 'package:shinnamon/pages/owner/lead_page.dart';
import 'package:shinnamon/pages/owner/visit_page.dart';
import 'package:shinnamon/pages/sales_page/account_page.dart';
import 'package:shinnamon/pages/sales_page/visit_page.dart';
import 'package:shinnamon/thema.dart';

class OMainPage extends StatefulWidget {
  const OMainPage({Key? key}) : super(key: key);

  @override
  _OMainPageState createState() => _OMainPageState();
}

class _OMainPageState extends State<OMainPage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = [
      OHomePage(),
      OLeadPage(),
      OVisitPage(),
      OAccountPage(),
    ];

    final bottomNavBarItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_outlined),
        label: 'Lead',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Visit',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Account',
      ),
    ];

    final bottomNavBar = BottomNavigationBar(
      items: bottomNavBarItem,
      onTap: onItemTapped,
      currentIndex: currentIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kGreyColor,
      showSelectedLabels: false,
    );

    return Scaffold(
      body: listPage[currentIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
