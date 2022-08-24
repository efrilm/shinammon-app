import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/markom/utils_sold/detail_sold_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/lead_card.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading.dart';

import '../../../const.dart';

class MCashKerasPage extends StatefulWidget {
  const MCashKerasPage({Key? key}) : super(key: key);

  @override
  _MCashKerasPageState createState() => _MCashKerasPageState();
}

class _MCashKerasPageState extends State<MCashKerasPage> {
  var isLoading = false;
  var isData = false;
  var paymentMethod = 'Cash Keras';
  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('Id' + pref.getString('userId')!);
    final response = await http.get(
      Uri.parse(AppUrl.leadPmM +
          '?id=' +
          pref.getString('userId')! +
          '&project_code=' +
          AppCode.project +
          '&payment_method=' +
          paymentMethod),
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
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Cash Keras",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
      );
    }

    return Scaffold(
      appBar: header(),
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
                        isHome: true,
                        noHome: l.noHome!,
                        isPayment: true,
                        paymentType: l.paymentMethod!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MDetailSoldPage(l),
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
