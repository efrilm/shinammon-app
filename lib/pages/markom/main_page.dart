import 'package:flutter/material.dart';
import 'package:shinnamon/pages/markom/account_page.dart';
import 'package:shinnamon/pages/markom/home_page.dart';
import 'package:shinnamon/pages/markom/lead_page.dart';
import 'package:shinnamon/pages/markom/visit_page.dart';
import 'package:shinnamon/thema.dart';

class MMainPage extends StatefulWidget {
  const MMainPage({Key? key}) : super(key: key);

  @override
  _MMainPageState createState() => _MMainPageState();
}

class _MMainPageState extends State<MMainPage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listPage = [
      MHomePage(),
      MLeadPage(),
      MVisitPage(),
      MAccountPage(),
    ];

    final bottomNavbarItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        label: 'Beranda',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_outlined),
        label: 'Lead',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Datang',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Akun',
      ),
    ];

    final bottomNavbar = BottomNavigationBar(
      items: bottomNavbarItem,
      backgroundColor: kWhiteColor,
      showSelectedLabels: false,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kGreyColor,
      onTap: onItemTapped,
      currentIndex: currentIndex,
    );

    return Scaffold(
      body: listPage[currentIndex],
      bottomNavigationBar: bottomNavbar,
    );
  }
}
