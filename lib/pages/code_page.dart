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

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  var isLoading = false;

  TextEditingController codeController = TextEditingController();

  handleCode() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(AppUrl.code), body: {
      'code_project': AppCode.project,
      'code_user': codeController.text,
    });
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      String? message = data['message'];
      int value = data['value'];
      Navigator.pushNamed(context, '/sign-up');
      setState(() {
        saveValue(value);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!, style: whiteTextStyle),
        ),
      );
    } else if (response.statusCode == 500) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kode Yang Anda Masukkan Salah", style: whiteTextStyle),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  saveValue(int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setInt('value', value);
      pref.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Kode Project",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kBlackColor,
            size: 28,
          ),
        ),
      );
    }

    Widget bottomNavbar() {
      return Container(
        height: 80,
        padding: EdgeInsets.symmetric(
          horizontal: hMargin,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(dRadius),
            topRight: Radius.circular(dRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.1),
              offset: Offset(0, -15),
              blurRadius: 20,
            ),
          ],
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleCode();
                },
                text: 'Selanjutnya',
              ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: header(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: hMargin,
            vertical: 20,
          ),
          child: InputField(
            controller: codeController,
            hintText: "Masukkan Kode Project",
          ),
        ),
      ),
      bottomNavigationBar: bottomNavbar(),
    );
  }
}
