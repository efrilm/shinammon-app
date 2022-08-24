import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/visit_model.dart';
import 'package:shinnamon/pages/sales_page/actions/add_tracking.dart';
import 'package:shinnamon/pages/utilities/tracking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/icon_card.dart';
import 'package:shinnamon/widgets/information_date_card.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/information_user_card.dart';
import 'package:shinnamon/widgets/note_card.dart';
import 'package:shinnamon/widgets/visit_date_card.dart';
import 'package:http/http.dart' as http;

class SDetailWillVisitPage extends StatefulWidget {
  final Visit model;
  SDetailWillVisitPage(this.model);
  @override
  _SDetailWillVisitPageState createState() => _SDetailWillVisitPageState();
}

class _SDetailWillVisitPageState extends State<SDetailWillVisitPage> {
  var isLoading = false;
  String? salesName;
  String? markomName;
  getSales() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getUser + widget.model.salesId));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        salesName = data['data']['user_name'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getMarkom() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getUser + widget.model.markomId));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        markomName = data['data']['user_name'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  handleAlreadyVisit() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(Uri.parse(AppUrl.addAlreadyVisit), body: {
      'id': widget.model.visitId,
      'id_lead': widget.model.leadId,
      'id_user': pref.getString('userId'),
      'project_code': AppCode.project,
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
    final response = await http.get(Uri.parse(AppUrl.notifAlreadyVisit +
        '?id=' +
        pref.getString('userId')! +
        '&notif_id=' +
        AppCode.notificationId +
        '&rest_api_key=' +
        AppCode.restApiKey));
  }

  alertAlreadyVisited() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Apakah Tamu Anda Sudah Datang?",
              style: primaryTextStyle,
            ),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Tidak", style: blueTextStyle),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: kBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(dRadius),
                        ),
                      ),
                      onPressed: () {
                        handleAlreadyVisit();
                        getNotif();
                      },
                      child: Text("Ya", style: whiteTextStyle),
                    ),
            ],
          );
        });
  }

  String? dateAdd;
  String? dateFollowUp;
  String? dateWillVisit;
  getDate() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getDate + widget.model.leadId));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        dateAdd = data[0]['date_add'];
        dateFollowUp = data[0]['date_follow_up'];
        dateWillVisit = data[0]['date_will_visit'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSales();
    getMarkom();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          widget.model.fullName,
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
          top: 40,
          right: hMargin,
          left: hMargin,
        ),
        child: CustomButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrackingPage(widget.model.leadId)));
          },
          text: "Tracking",
        ),
      );
    }

    Widget bottomNavbar() {
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(dRadius),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              color: kBlackColor.withOpacity(0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              width: 230,
              onPressed: () {
                alertAlreadyVisited();
              },
              text: "Sudah Datang",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      bottomNavigationBar: bottomNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTracking(widget.model.leadId)));
        },
        child: Icon(Icons.add),
        backgroundColor: kBlueColor,
      ),
      body: ListView(
        children: [
          VisitDateCard(
            date: widget.model.visitDate,
          ),
          InformationLeadCard(
            name: widget.model.fullName,
            noWhatsapp: widget.model.noWhatsapp,
            source: widget.model.source,
            date: widget.model.updateDate,
          ),
          NoteCard(
            text: widget.model.note,
          ),
          InformationUserCard(
            salesName: salesName == null ? 'N/A' : salesName!,
            markomName: markomName == null ? 'N/A' : markomName!,
          ),
          InformationDateCard(
            dateAdd: dateAdd == null ? 'N/A' : dateAdd!,
            dateFollowUp: dateFollowUp == null ? 'N/A' : dateFollowUp!,
            dateWillVisited: dateWillVisit == null ? 'N/A' : dateWillVisit!,
          ),
          button(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
