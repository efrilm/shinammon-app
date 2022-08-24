import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading_button.dart';

class AddFollowUpPage extends StatefulWidget {
  final Lead model;
  AddFollowUpPage(this.model);
  @override
  _AddFollowUpPageState createState() => _AddFollowUpPageState();
}

class _AddFollowUpPageState extends State<AddFollowUpPage> {
  var isLoading = false;

  TextEditingController noteController = TextEditingController();

  handleFollowUp() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(AppUrl.addFollowUp), body: {
      'id': widget.model.leadId,
      'note': noteController.text,
      'sales_id': pref.getString('userId'),
      'project_code': AppCode.project,
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = jsonDecode(response.body);
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
    }
  }

  getNotif() async {
    final response = await http.get(Uri.parse(AppUrl.notifFollowUp +
        '?id=' +
        widget.model.markomId +
        '&sales_id=' +
        widget.model.salesId +
        '&notif_id=' +
        AppCode.notificationId));
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Tambah Follow Up',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget inputText() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: InputField(
          lines: 3,
          controller: noteController,
          hintText: "Keterangan",
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
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleFollowUp();
                  getNotif();
                },
                text: "Konfirmasi",
              ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          inputText(),
          button(),
        ],
      ),
    );
  }
}
