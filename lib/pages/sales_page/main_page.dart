import 'package:flutter/material.dart';
import 'package:shinnamon/pages/sales_page/account_page.dart';
import 'package:shinnamon/pages/sales_page/home_page.dart';
import 'package:shinnamon/pages/sales_page/lead_page.dart';
import 'package:shinnamon/pages/sales_page/visit_page.dart';
import 'package:shinnamon/thema.dart';

class SMainPage extends StatefulWidget {
  const SMainPage({Key? key}) : super(key: key);

  @override
  _SMainPageState createState() => _SMainPageState();
}

class _SMainPageState extends State<SMainPage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = [
      SHomePage(),
      SLeadPage(),
      SVisitPage(),
      SAccountPage(),
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
