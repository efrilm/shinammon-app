import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/profile_card.dart';
import 'package:shinnamon/widgets/setting_card.dart';
import 'package:http/http.dart' as http;

class MAccountPage extends StatefulWidget {
  const MAccountPage({Key? key}) : super(key: key);

  @override
  _MAccountPageState createState() => _MAccountPageState();
}

class _MAccountPageState extends State<MAccountPage> {
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

  String? codeMarkom;
  String? codeSales;
  String? codeOwner;

  getProject() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.project + '?code=' + AppCode.project));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        codeMarkom = data['data'][0]['code_markom'];
        codeSales = data['data'][0]['code_sales'];
        codeOwner = data['data'][0]['code_owner'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getProject();
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
        name: name == null ? 'none' : name!,
        email: email == null ? 'none' : email!,
        imageUrl: AppUrl.imgProfileUrl + '/' + image,
        onProfileTap: () {
          Navigator.pushNamed(context, '/profile');
        },
        onImageTap: () {},
      );
    }

    Widget code() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
          bottom: 15,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [shadow],
        ),
        child: Row(
          children: [
            DividerVertical(
              height: 80,
            ),
            Container(
              width: 285,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  HeaderCard(
                    text: "Kode",
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kode Markom",
                        style: blackTextStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          codeMarkom == null ? 'None' : codeMarkom!,
                          style: blueTextStyle,
                        ),
                        onLongPress: () {
                          Clipboard.setData(
                            new ClipboardData(text: "$codeMarkom"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Kode Markom Copy To Clipboard"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kode Sales",
                        style: blackTextStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          codeSales == null ? 'None' : codeSales!,
                          style: blueTextStyle,
                        ),
                        onLongPress: () {
                          Clipboard.setData(
                            new ClipboardData(text: "$codeSales"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Kode Sales Copy To Clipboard"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kode Owner",
                        style: blackTextStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          codeOwner == null ? 'None' : codeOwner!,
                          style: blueTextStyle,
                        ),
                        onLongPress: () {
                          Clipboard.setData(
                            new ClipboardData(text: "$codeOwner"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Kode Owner Copy To Clipboard"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
                Navigator.pushNamed(context, '/m-kpr');
              },
            ),
            SettingCard(
              icon: Icons.paid_outlined,
              title: "Cash Keras",
              onTap: () {
                Navigator.pushNamed(context, '/m-cash-keras');
              },
            ),
            SettingCard(
              icon: Icons.payments_outlined,
              title: "Cash Bertahap",
              onTap: () {
                Navigator.pushNamed(context, '/m-cash-bertahap');
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
              icon: Icons.label_outline,
              title: "Product Knowladge ",
              onTap: () {},
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
            SettingCard(
              icon: Icons.person_pin_outlined,
              title: "Daftar Sales",
              onTap: () {
                Navigator.pushNamed(context, "/list-sales");
              },
            ),
            SettingCard(
              icon: Icons.person_pin_outlined,
              title: "Permintaan Sales",
              onTap: () {
                Navigator.pushNamed(context, "/sales-request");
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
                  code(),
                  soldType(),
                  accountSetting(),
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
