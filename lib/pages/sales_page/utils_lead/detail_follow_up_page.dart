import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/sales_page/actions/add_reservation_page.dart';
import 'package:shinnamon/pages/sales_page/actions/add_tracking.dart';
import 'package:shinnamon/pages/sales_page/actions/add_visit_page.dart';
import 'package:shinnamon/pages/utilities/tracking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/information_user_card.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/note_card.dart';
import 'package:http/http.dart' as http;

class SDetailFollowUpPage extends StatefulWidget {
  final Lead model;
  SDetailFollowUpPage(this.model);
  @override
  _SDetailFollowUpPageState createState() => _SDetailFollowUpPageState();
}

class _SDetailFollowUpPageState extends State<SDetailFollowUpPage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSales();
    getMarkom();
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

    Widget bottomNavBar() {
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: kBlackColor.withOpacity(0.1),
                offset: Offset(0, -15),
                blurRadius: 20,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 160,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddReservation(widget.model.leadId)));
              },
              text: "Reservasi",
              color: kBlueColor,
            ),
            CustomButton(
              width: 160,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddVisitPage(widget.model)));
              },
              text: "Visit",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
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
      bottomNavigationBar: bottomNavBar(),
      body: isLoading
          ? Loading()
          : ListView(
              children: [
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
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    left: hMargin,
                    right: hMargin,
                  ),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TrackingPage(widget.model.leadId)));
                    },
                    text: "Tracking",
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
    );
  }
}
