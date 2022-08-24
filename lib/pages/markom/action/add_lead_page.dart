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

class AddLeadPage extends StatefulWidget {
  @override
  _AddLeadPageState createState() => _AddLeadPageState();
}

class _AddLeadPageState extends State<AddLeadPage> {
  var sumberSelection;

  List listSumber = ['Facebook', "Instagram"];

  String idSales = "";

  getSales() async {
    final response =
        await http.get(Uri.parse(AppUrl.antrian + AppCode.project));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        idSales = data[0]['id_user'];
      });
      print(idSales);
    }
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  String sumber = "";

  bool isLoading = false;

  addLead() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(AppUrl.addLead), body: {
      'full_name': namaController.text,
      'no_whatsapp': noTelpController.text,
      'address': alamatController.text,
      'note': keteranganController.text,
      'sales_id': idSales,
      'source': sumberSelection,
      'markom_id': pref.getString('userId'),
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
        print("Sumber $sumberSelection");

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil di Tambah Kan!',
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
        print(sumber);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  getNotif() async {
    final response = await http.get(Uri.parse(
      AppUrl.notifLead +
          '?id=' +
          idSales +
          '&notif_id=' +
          AppCode.notificationId,
      ));
  }

  @override
  void initState() {
    super.initState();
    getSales();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          "Tambah Lead",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget sumberDropdown() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: kGreyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(dRadius),
        ),
        child: DropdownButtonFormField(
          hint: Text(
            "Ganti Sumber",
            style: greyTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          onSaved: (e) => sumberSelection,
          value: sumberSelection,
          style: blackTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: listSumber.map((value) {
            return DropdownMenuItem(
              child: Text(
                value,
                style: blackTextStyle,
              ),
              value: value,
            );
          }).toList(),
          onChanged: (newvalue) {
            setState(() {
              sumberSelection = newvalue;
            });
          },
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
                text: 'Tambah',
                onPressed: () {
                  addLead();
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
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: namaController,
            hintText: "Nama Lengkap",
          ),
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: alamatController,
            hintText: "Alamat",
          ),
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: noTelpController,
            hintText: "No. Whatsapp",
          ),
          SizedBox(
            height: 20,
          ),
          sumberDropdown(),
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: keteranganController,
            hintText: "Keterangan",
            lines: 3,
          ),
          button(),
        ],
      ),
    );
  }
}
