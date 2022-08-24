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

class AddSoldPage extends StatefulWidget {
  final String leadId;
  final String homeId;
  AddSoldPage(this.leadId, this.homeId);
  @override
  _AddSoldPageState createState() => _AddSoldPageState();
}

class _AddSoldPageState extends State<AddSoldPage> {
  bool isLoading = false;

  TextEditingController noteController = TextEditingController();

  handleSold() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(AppUrl.addSold), body: {
      "lead_id": widget.leadId,
      "home_id": widget.homeId,
      'user_id': pref.getString('userId'),
      'note': noteController.text,
      'project_code': AppCode.project,
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(response.body);
      int value = data['value'];
      String message = data['message'];
      if (value == 1) {
        print(message);
        Navigator.pushNamedAndRemoveUntil(
            context, '/sales-main', (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil!',
              style: whiteTextStyle,
            ),
            backgroundColor: Colors.green[600],
            duration: const Duration(milliseconds: 1500),
            width: 200.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        print(message);
      }
    } else {
      print('gagal');
    }
    setState(() {
      isLoading = false;
    });
  }

  getNotif() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(AppUrl.notifSold +
        '?id=' +
        pref.getString('userId')! +
        '&notif_id=' +
        AppCode.notificationId +
        '&rest_api_key=' +
        AppCode.restApiKey));
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Penjualan",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                text: 'Konfirmasi',
                onPressed: () {
                  handleSold();
                  getNotif();
                },
              ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: hMargin,
        ),
        children: [
          SizedBox(height: 20),
          InputField(
            lines: 3,
            controller: noteController,
            hintText: "Keterangan",
          ),
          button(),
        ],
      ),
    );
  }
}
