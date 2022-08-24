import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/visit_model.dart';
import 'package:shinnamon/pages/owner/utils_visit/detail_will_visit_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/lead_card.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading.dart';

class OWillVisitPage extends StatefulWidget {
  const OWillVisitPage({Key? key}) : super(key: key);

  @override
  State<OWillVisitPage> createState() => _OWillVisitPageState();
}

class _OWillVisitPageState extends State<OWillVisitPage> {
  var isLoading = false;
  var isData = false;
  String status = '1';
  List<Visit> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('Id' + pref.getString('userId')!);
    final response = await http.get(
      Uri.parse(AppUrl.visitO +
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
            list.add(Visit.fromJson(i));
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ODetailWillVisitPage(l),
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
