import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/markom/action/edit_lead_page.dart';
import 'package:shinnamon/pages/utilities/tracking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/dialog_delete.dart';
import 'package:shinnamon/widgets/information_lead_card.dart';
import 'package:shinnamon/widgets/information_user_card.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/note_card.dart';
import 'package:http/http.dart' as http;

class MDetailNewLeadPage extends StatefulWidget {
  final Lead model;
  MDetailNewLeadPage(this.model);
  @override
  _MDetailNewLeadPageState createState() => _MDetailNewLeadPageState();
}

class _MDetailNewLeadPageState extends State<MDetailNewLeadPage> {
  var salesSelection;
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

  delete() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.delete(Uri.parse(AppUrl.delete), body: {
      'id': widget.model.leadId,
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, '/markom-main', (route) => false);
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
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          widget.model.fullName,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditLeadPage(widget.model),
                ),
              );
            },
            icon: Icon(
              Icons.edit_outlined,
              color: kBlueColor,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogDelete(
                      onYesTapped: () {
                        delete();
                      },
                    );
                  });
            },
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red[700],
            ),
          ),
        ],
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
        ),
        child: Column(
          children: [
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TrackingPage(widget.model.leadId)));
              },
              text: "Tracking",
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
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
                button(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
    );
  }
}
