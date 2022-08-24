import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/markom/utils_lead/detail_booking_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/lead_card.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading.dart';
import '../../../thema.dart';

class MBookingPage extends StatefulWidget {
  const MBookingPage({Key? key}) : super(key: key);

  @override
  _MBookingPageState createState() => _MBookingPageState();
}

class _MBookingPageState extends State<MBookingPage> {
  var isLoading = false;
  var isData = false;
  String status = '5';
  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('Id' + pref.getString('userId')!);
    final response = await http.get(
      Uri.parse(AppUrl.leadAndHomeM +
          '?id=' +
          pref.getString('userId')! +
          '&status=' +
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
          print(data);
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
    return RefreshIndicator(
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
                      isHome: true,
                      noHome: l.noHome!,
                      isPayment: true,
                      paymentType: l.paymentMethod!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MDetailBookingPage(l),
                          ),
                        );
                      },
                    );
                  },
                )
              : DataNotFound(),
    );
  }
}
