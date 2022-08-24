import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/pages/profile/change_email_page.dart';
import 'package:shinnamon/pages/profile/change_name_page.dart';
import 'package:shinnamon/pages/profile/change_no_telp_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/name_card.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var isLoading = false;
  String? name;
  String imageP = '';
  String? email;
  String? noWhatsapp;

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
        imageP = data['data']['photo'];
        email = data['data']['email'];
        noWhatsapp = data['data']['no_telp'];
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
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Profil",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
      );
    }

    Widget image() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/change-image');
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(AppUrl.imgProfileUrl + '/' + imageP),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(dRadius),
                ),
              ),
              Positioned(
                right: 96,
                bottom: 15,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(dRadius),
                  ),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: kWhiteColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget divider() {
      return Container(
        width: double.infinity,
        height: 4,
        decoration: BoxDecoration(
          color: kGreyLightColor,
        ),
      );
    }

    Widget inputText() {
      return Container(
        margin: EdgeInsets.only(
          left: hMargin,
          right: hMargin,
          top: 20,
        ),
        child: Column(
          children: [
            NameCard(
              text: "Email",
              subText: email == null ? 'none' : email!,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeEmailPage()));
              },
            ),
            NameCard(
              text: "Nama Lengkap",
              subText: name == null ? 'none' : name!,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeNamePage()));
              },
            ),
            NameCard(
              text: "No. Whatsapp",
              subText: noWhatsapp == null ? 'none' : noWhatsapp!,
              onTap: () {
                                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeNoTelpPage()));
              },
            ),
          ],
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
                  image(),
                  divider(),
                  inputText(),
                ],
              ),
      ),
    );
  }
}
