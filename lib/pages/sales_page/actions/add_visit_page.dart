import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:shinnamon/widgets/loading_button.dart';

class AddVisitPage extends StatefulWidget {
  final Lead model;
  AddVisitPage(this.model);
  @override
  _AddVisitPageState createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  var isLoading = false;

  DateTime? datePick;

  void showDatePick() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: "Pilih Tanggal Visit",
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          datePick = value;
        });
      }
    });
  }

  TextEditingController noteController = TextEditingController();

  handleVisit() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(AppUrl.addVisit), body: {
      'id': widget.model.leadId,
      'id_user': pref.getString('userId'),
      'date_visit': datePick.toString(),
      'project_code': AppCode.project,
      'note': noteController.text,
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(AppUrl.notifVisit +
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
          'Tambah Visit',
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

    Widget inputNote() {
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

    Widget date() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGreyLightColor,
                  borderRadius: BorderRadius.circular(dRadius),
                ),
                child: Text(
                  datePick == null
                      ? 'Pilih Tanggal'
                      : '${DateFormat.yMMMMd().format(datePick!)}',
                  style: blackTextStyle,
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(dRadius),
              ),
              child: IconButton(
                onPressed: () {
                  showDatePick();
                },
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: kWhiteColor,
                ),
              ),
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
        child: isLoading
            ? LoadingButton()
            : CustomButton(
                onPressed: () {
                  handleVisit();
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
          inputNote(),
          date(),
          button(),
        ],
      ),
    );
  }
}
