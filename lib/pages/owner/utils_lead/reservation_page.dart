import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/owner/utils_lead/detail_reservation_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/lead_card.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:http/http.dart' as http;

class OReservationPage extends StatefulWidget {
  const OReservationPage({Key? key}) : super(key: key);

  @override
  _OReservationPageState createState() => _OReservationPageState();
}

class _OReservationPageState extends State<OReservationPage> {
  var isLoading = false;
  var isData = false;
  String status = '4';
  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    final response = await http.get(
      Uri.parse(AppUrl.leadAndHomeO +
          '?status=' +
          status +
          '&project_code=' +
          AppCode.project),
    );
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          for (Map i in data) {
            list.add(Lead.fromJson(i));
          }
          isLoading = false;
          isData = true;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isData = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getLead,
        child: isLoading
            ? Loading()
            : isData
                ? ListView.builder(
                    padding: EdgeInsets.only(
                      left: hMargin,
                      right: hMargin,
                      bottom: 80,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final l = list[i];
                      return LeadCard(
                        name: l.fullName,
                        date: l.updateDate,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ODetailReservationPage(l),
                            ),
                          );
                        },
                      );
                    },
                  )
                : DataNotFound(),
      ),
    );
  }
}
