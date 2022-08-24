import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/sales_page/actions/add_follow_up_page.dart';
import 'package:shinnamon/pages/sales_page/actions/add_tracking.dart';
import 'package:shinnamon/pages/utilities/tracking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/icon_card.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/information_user_card.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/note_card.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class SDetailNewLeadPage extends StatefulWidget {
  final Lead model;
  SDetailNewLeadPage(this.model);
  @override
  _SDetailNewLeadPageState createState() => _SDetailNewLeadPageState();
}

class _SDetailNewLeadPageState extends State<SDetailNewLeadPage> {
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

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: widget.model.noWhatsapp,
      text: " ",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await urlLauncher.launch('$link');
  }

  launchPhoneCall(String phoneNumber) {
    urlLauncher.launch('tel:$phoneNumber');
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
            IconCard(
              height: 50,
              icon: Icons.phone_outlined,
              onTap: () {
                launchPhoneCall(widget.model.noWhatsapp);
              },
              color: kBlueColor,
            ),
            IconCard(
              height: 50,
              icon: Icons.message_outlined,
              onTap: () {
                launchWhatsApp();
              },
              color: kBlueColor,
            ),
            CustomButton(
              width: 230,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFollowUpPage(widget.model),
                  ),
                );
              },
              text: "Follow Up",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      bottomNavigationBar: bottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTracking(widget.model.leadId)));
        },
        backgroundColor: kBlueColor,
      ),
      body: isLoading
          ? Loading()
          : ListView(
              children: [
                InformationLeadCard(
                  name: widget.model.fullName,
                  noWhatsapp: widget.model.noWhatsapp,
                  source: widget.model.source,
                  date: widget.model.dateAdd,
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
                SizedBox(height: 100),
              ],
            ),
    );
  }
}
