import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/pages/markom/main_page.dart';
import 'package:shinnamon/pages/owner/main_page.dart';
import 'package:shinnamon/pages/sales_page/main_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

enum LoginStatus {
  notSignIn,
  signInSales,
  signInMarkom,
  signInOwner,
}

class _SignInPageState extends State<SignInPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false;

  handleSignIn() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(AppUrl.signIn), body: {
      'email': usernameController.text,
      'password': passwordController.text,
      'code': AppCode.project,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(data);
      String? message = data['message'];
      String? userId = data['data']['id_user'];
      String? email = data['data']['email'];
      String? name_user = data['data']['user_name'];
      String? level = data['data']['level'];
      String? projectCode = data['data']['project_code'];
      if (value == 1) {
        print(message);
        if (level == "1") {
          setState(() {
            _loginStatus = LoginStatus.signInSales;
            save(value, userId!, email!, name_user!, level!, projectCode!);
          });
        } else if (level == "2") {
          setState(() {
            _loginStatus = LoginStatus.signInMarkom;
            save(value, userId!, email!, name_user!, level!, projectCode!);
          });
        } else if (level == "3") {
          setState(() {
            _loginStatus = LoginStatus.signInOwner;
            save(value, userId!, email!, name_user!, level!, projectCode!);
          });
        }
      } else {
        print(message);
      }
    } else if (response.statusCode == 500) {
      setState(() {
        isLoading = false;
      });
      if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password Salah', style: whiteTextStyle),
          ),
        );
      } else if (value == 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email Belum Aktif', style: whiteTextStyle),
          ),
        );
      } else if (value == 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email Belum Terdaftar', style: whiteTextStyle),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  save(
    int value,
    String userId,
    String email,
    String name_user,
    String level,
    String projectCode,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setInt("value", value);
      pref.setString("userId", userId);
      pref.setString("email", email);
      pref.setString("name_user", name_user);
      pref.setString("level", level);
      pref.setString("projectCode", projectCode);
      // ignore: deprecated_member_use
      pref.commit();
    });
  }

  var saved;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    saved = pref.getString('level');
    setState(() {
      _loginStatus = saved == "1"
          ? LoginStatus.signInSales
          : _loginStatus = saved == "2"
              ? LoginStatus.signInMarkom
              : _loginStatus = saved == '3'
                  ? LoginStatus.signInOwner
                  : LoginStatus.notSignIn;
    });
    print("Level: $saved");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(
          left: hMargin,
          top: 20,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          left: hMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey,",
              style: blackTextStyle.copyWith(
                fontSize: 30,
                fontWeight: extraBold,
              ),
            ),
            Text(
              "Masuk Sekarang.",
              style: blackTextStyle.copyWith(
                fontSize: 30,
                fontWeight: extraBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget create() {
      return Container(
        margin: EdgeInsets.only(
          left: hMargin,
          top: 20,
        ),
        child: Row(
          children: [
            Text(
              "Jika Kamu Pengguna Baru / ",
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/code');
              },
              child: Text(
                "Buat Akun",
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputText() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          right: hMargin,
          left: hMargin,
        ),
        child: Column(
          children: [
            InputField(
              autoFocus: false,
              hintText: "Email",
              controller: usernameController,
            ),
            SizedBox(height: 20),
            InputField(
              autoFocus: false,
              obscureText: true,
              controller: passwordController,
              hintText: "Kata Sandi",
            ),
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return Container(
        margin: EdgeInsets.only(
          left: hMargin,
          top: 20,
        ),
        child: Row(
          children: [
            Text(
              "Lupa Kata Sandi ? ",
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
            ),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Reset",
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 50,
          left: hMargin,
          right: hMargin,
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleSignIn();
                },
                text: "Masuk",
              ),
      );
    }

    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: kWhiteColor,
          body: SafeArea(
            child: ListView(
              children: [
                logo(),
                SizedBox(height: 80),
                title(),
                create(),
                inputText(),
                forgotPassword(),
                button(),
                SizedBox(height: 50),
              ],
            ),
          ),
        );
        // ignore: dead_code
        break;
      case LoginStatus.signInSales:
        return SMainPage();
        // ignore: dead_code
        break;
      case LoginStatus.signInMarkom:
        return MMainPage();
        // ignore: dead_code
        break;
      case LoginStatus.signInOwner:
        return OMainPage();
        // ignore: dead_code
        break;
    }
  }
}
