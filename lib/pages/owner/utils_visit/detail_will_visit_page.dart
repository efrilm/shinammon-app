import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/visit_model.dart';
import 'package:shinnamon/pages/utilities/tracking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/information_date_card.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/information_user_card.dart';
import 'package:shinnamon/widgets/note_card.dart';
import 'package:shinnamon/widgets/visit_date_card.dart';
import 'package:http/http.dart' as http;

class ODetailWillVisitPage extends StatefulWidget {
  final Visit model;
  ODetailWillVisitPage(this.model);
  @override
  _ODetailWillVisitPageState createState() => _ODetailWillVisitPageState();
}

class _ODetailWillVisitPageState extends State<ODetailWillVisitPage> {
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

    return Scaffold(
      appBar: header(),
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
