import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/loading_button.dart';

class AddReservation extends StatefulWidget {
  final String leadId;
  AddReservation(this.leadId);
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  var homeSelection;
  var paymentSelection;

  bool isLoading = false;

  List<dynamic> listRumah = [];
  List listPembayaran = ['KPR', 'Cash Keras', 'Cash Bertahap'];

  selectedHome() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(
          AppUrl.home + '?status=' + '1' + '&project_code=' + AppCode.project),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        isLoading = false;
        listRumah = data;
      });
    }
  }

  TextEditingController feeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  handleReservasition() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(AppUrl.addReservation), body: {
      'lead_id': widget.leadId,
      'home_id': homeSelection,
      'user_id': pref.getString('userId'),
      'fee_reservation': feeController.text,
      'payment_method': paymentSelection,
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
    }
    setState(() {
      isLoading = false;
    });
  }

  getNotif() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(AppUrl.notifReservation +
        '?id=' +
        pref.getString('userId')! +
        '&notif_id=' +
        AppCode.notificationId +
        '&rest_api_key=' +
        AppCode.restApiKey));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedHome();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Reservasi",
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

    Widget rumahDropdown() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: kGreyLightColor,
          borderRadius: BorderRadius.circular(dRadius),
        ),
        child: DropdownButtonFormField(
          hint: Text(
            "Pilih Rumah",
          ),
          onSaved: (e) => homeSelection,
          value: homeSelection,
          style: blackTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: listRumah.map((value) {
            return DropdownMenuItem(
              child: Text(
                "${value['no_home']} - ${value['type_home']}",
                style: blackTextStyle,
              ),
              value: value['id_home'],
            );
          }).toList(),
          onChanged: (newvalue) {
            setState(() {
              homeSelection = newvalue;
            });
          },
        ),
      );
    }

    Widget paymentDropdown() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: kGreyLightColor,
          borderRadius: BorderRadius.circular(dRadius),
        ),
        child: DropdownButtonFormField(
          hint: Text(
            "Pilih Jenis Pembayaran",
          ),
          onSaved: (e) => paymentSelection,
          value: paymentSelection,
          style: blackTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: listPembayaran.map((value) {
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
              paymentSelection = newvalue;
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
                text: 'Konfirmasi',
                onPressed: () {
                  handleReservasition();
                  getNotif();
                },
              ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: isLoading
            ? Loading()
            : ListView(
                padding: EdgeInsets.only(
                  top: 20,
                  left: hMargin,
                  right: hMargin,
                ),
                children: [
                  rumahDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    controller: feeController,
                    keyboardType: TextInputType.number,
                    hintText: "Fee Reservasi",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  paymentDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    lines: 3,
                    controller: noteController,
                    hintText: "Keterangan",
                  ),
                  button(),
                ],
              ),
      ),
    );
  }
}
