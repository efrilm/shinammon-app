import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/models/tracking_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/tracking_card.dart';
import 'package:http/http.dart' as http;

class TrackingPage extends StatefulWidget {
  final String leadId;
  TrackingPage(this.leadId);
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  bool isLoading = false;
  bool isData = false;

  List<Tracking> list = [];

  Future<void> getTracking() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    final response = await http.get(Uri.parse(
      AppUrl.tracking + '?id=' + widget.leadId,
    ));
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
            list.add(Tracking.fromJson(i));
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
    getTracking();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Tracking',
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

    return Scaffold(
      appBar: header(),
      body: RefreshIndicator(
        onRefresh: getTracking,
        child: isLoading
            ? Loading()
            : isData
                ? ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final l = list[i];
                      return TrackingCard(
                          userName: l.userName,
                          note: l.note,
                          date: l.createDate,
                          trackingId: l.trackingId);
                    },
                  )
                : DataNotFound(),
      ),
    );
  }
}
