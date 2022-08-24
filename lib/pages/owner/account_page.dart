import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/profile_card.dart';
import 'package:shinnamon/widgets/setting_card.dart';
import 'package:http/http.dart' as http;

class OAccountPage extends StatefulWidget {
  const OAccountPage({Key? key}) : super(key: key);

  @override
  _OAccountPageState createState() => _OAccountPageState();
}

class _OAccountPageState extends State<OAccountPage> {
  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove("value");
      pref.remove("userId");
      pref.remove("email");
      pref.remove("name_user");
      pref.remove("level");
      pref.remove("projectCode");
      pref.commit();
      Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
    });
  }

  var isLoading = false;
  String? name;
  String image = '';
  String? email;

  getUser() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(AppUrl.getUser + prefs.getString('userId')!),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        name = data['data']['user_name'];
        image = data['data']['photo'];
        email = data['data']['email'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Koneksi Tidak Stabil',
            style: whiteTextStyle,
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: Text(
          'Profil',
          style: primaryTextStyle.copyWith(
            fontSize: 26,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget profile() {
      return ProfileCard(
        name: name == null ? 'None' : name!,
        email: email == null ? 'None' : email!,
        imageUrl: AppUrl.imgProfileUrl + '/' + image,
        onProfileTap: () {
          Navigator.pushNamed(context, '/profile');
        },
        onImageTap: () {},
      );
    }

    Widget divider() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
        ),
        height: 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGreyLightColor,
        ),
      );
    }

    Widget soldType() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terjual',
              style: primaryTextStyle,
            ),
            SettingCard(
              title: "KPR",
              icon: Icons.credit_card,
              onTap: () {
                Navigator.pushNamed(context, '/o-kpr');
              },
            ),
            SettingCard(
              icon: Icons.paid_outlined,
              title: "Cash Keras",
              onTap: () {
                Navigator.pushNamed(context, '/o-cash-keras');
              },
            ),
            SettingCard(
              icon: Icons.payments_outlined,
              title: "Cash Bertahap",
              onTap: () {
                Navigator.pushNamed(context, '/o-cash-bertahap');
              },
            ),
          ],
        ),
      );
    }

    Widget accountSetting() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PENGATURAN AKUN",
              style: primaryTextStyle,
            ),
            SettingCard(
              title: "Profil",
              icon: Icons.person_outline,
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            SettingCard(
              icon: Icons.lock_outlined,
              title: "Ganti Kata Sandi",
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
            ),
          ],
        ),
      );
    }

    Widget insight() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "INSIGHT",
              style: primaryTextStyle.copyWith(),
            ),
            SettingCard(
              icon: Icons.assignment_outlined,
              title: "Semua Lead",
              onTap: () {
                Navigator.pushNamed(context, "/all-lead");
              },
            ),
            SettingCard(
              icon: Icons.person_pin,
              title: "Lead Markom",
              onTap: () {
                Navigator.pushNamed(context, "/lead-markom");
              },
            ),
            SettingCard(
              icon: Icons.assignment_ind_outlined,
              title: "Lead Sales",
              onTap: () {
                Navigator.pushNamed(context, "/lead-sales");
              },
            ),
          ],
        ),
      );
    }

    Widget general() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UMUM",
              style: primaryTextStyle.copyWith(),
            ),
            SettingCard(
              icon: Icons.home_work_outlined,
              title: "Master stock",
              onTap: () {
                Navigator.pushNamed(context, "/master-stock");
              },
            ),
            SettingCard(
              icon: Icons.pan_tool_outlined,
              title: "Daftar Absen",
              onTap: () {
                Navigator.pushNamed(context, "/absen");
              },
            ),
          ],
        ),
      );
    }

    Widget advanced() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LANJUTAN",
              style: primaryTextStyle.copyWith(),
            ),
            SettingCard(
              icon: Icons.policy,
              title: "Kebijakan Pribadi",
              onTap: () {
                Navigator.pushNamed(context, '/privacy-policy');
              },
            ),
            SettingCard(
              icon: Icons.privacy_tip,
              title: "Syarat dan Ketentuan",
              onTap: () {
                Navigator.pushNamed(context, '/term-conditions');
              },
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
        ),
        child: CustomButton(
          text: "Keluar",
          onPressed: () {
            signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Keluar!',
                  style: whiteTextStyle,
                ),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 1500),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, // Inner padding for SnackBar content.
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Loading()
            : ListView(
                children: [
                  header(),
                  profile(),
                  divider(),
                  soldType(),
                  accountSetting(),
                  insight(),
                  general(),
                  advanced(),
                  button(),
                  SizedBox(height: 100),
                ],
              ),
      ),
    );
  }
}
