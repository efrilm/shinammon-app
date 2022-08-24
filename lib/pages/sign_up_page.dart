import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var value;
  bool isLoading = false;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      value = pref.getInt('value');
    });
    print("Value Sign Up: $value");
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  handleSignUp() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse(AppUrl.signUp),
      body: {
        'user_name': userNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'no_telp': noTelpController.text,
        'address': addressController.text,
        'project_code': AppCode.project,
        'level': value == 1
            ? '2'
            : value == 2
                ? '1'
                : value == 3
                    ? '3'
                    : '0',
        'is_sales': value == 2 ? '1' : '0',
      },
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/sign-in');
      if (value == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Akun Markom Berhasil dibuat, Silahkan Login",
                style: whiteTextStyle),
          ),
        );
      } else if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Akun Sales Berhasil dibuat, Silahkan Login",
                style: whiteTextStyle),
          ),
        );
      } else if (value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Akun Owner Berhasil dibuat, Silahkan Login",
                style: whiteTextStyle),
          ),
        );
      }
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        pref.remove('value');
        pref.commit();
      });
    } else if (response.statusCode == 500) {
      setState(() {
        isLoading = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(data['message'], style: whiteTextStyle),
      //   ),
      // );
      print(data);
    }
    setState(() {
      isLoading = false;
    });
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
              "Buat Sekarang.",
              style: blackTextStyle.copyWith(
                fontSize: 30,
                fontWeight: extraBold,
              ),
            ),
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
            SizedBox(height: 15),
            InputField(
              controller: userNameController,
              hintText: "Nama Lengkap",
            ),
            SizedBox(height: 15),
            InputField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: "Email",
            ),
            SizedBox(height: 15),
            InputField(
              keyboardType: TextInputType.number,
              controller: noTelpController,
              hintText: "No. Whatsapp",
            ),
            SizedBox(height: 15),
            InputField(
              controller: addressController,
              hintText: "Alamat",
            ),
            SizedBox(height: 15),
            InputField(
              controller: passwordController,
              hintText: "Kata Sandi",
              obscureText: true,
            ),
          ],
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleSignUp();
                },
                text: "Buat",
              ),
      );
    }

    Widget text() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: Text(
          "Buat akunmu dengan indentitas kamu sendiri.",
          style: greyTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: ListView(
          children: [
            logo(),
            SizedBox(height: 50),
            title(),
            text(),
            inputText(),
            button(),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
