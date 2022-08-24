import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/count_card.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';
import 'package:shinnamon/widgets/header_card.dart';
import 'package:shinnamon/widgets/header_dashboard.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/new_lead_card.dart';
import 'package:shinnamon/widgets/page_title.dart';

import '../../const.dart';

class OHomePage extends StatefulWidget {
  const OHomePage({Key? key}) : super(key: key);

  @override
  _OHomePageState createState() => _OHomePageState();
}

class _OHomePageState extends State<OHomePage> {
  var isLoading = false;
  var isData = false;

  int value = 0;

  String userId = '';
  String image = '';
  String userName = '';

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId')!;
    });
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(AppUrl.getUser + prefs.getString('userId')!),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        userName = data['data']['user_name'];
        image = data['data']['photo'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Koneksi Tidak Stabil',
            style: whiteTextStyle,
          ),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  String? daily;
  String? weekly;
  String? monthly;

  getCount() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http
        .get(Uri.parse(AppUrl.getCount + "?project_code=" + AppCode.project));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        daily = data['daily']['count'];
        weekly = data['weekly']['count'];
        monthly = data['monthly']['count'];
      });
    }
  }

  String? omsetC;
  final price = NumberFormat("#,##0", "en_us");

  getOmset() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse(AppUrl.getOmset + '?project_code=' + AppCode.project));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        omsetC = data['count_omset'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    final response = await http.get(
      Uri.parse(AppUrl.leadLimitO + '?project_code=' + AppCode.project),
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
    getPref();
    getUser();
    getCount();
    getOmset();
    getLead();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return HeaderDashboard(
        name: userName,
        imageUrl: AppUrl.imgProfileUrl + "/" + image,
        positions: 'Sales Executive',
      );
    }

    Widget countCard() {
      return CountCard(
        countOfDaily: daily == null ? 'N/A' : daily!,
        countOfWeekly: weekly == null ? 'N/A' : weekly!,
        countOfMonthly: monthly == null ? 'N/A' : monthly!,
      );
    }

    Widget leadCard() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            PageTitle(
              title: "Lead Terbaru",
              isView: false,
            ),
            isLoading
                ? Loading()
                : isData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, i) {
                          final l = list[i];
                          return NewLeadCard(
                              name: l.fullName,
                              date: l.dateAdd,
                              onTap: () {},
                              status: l.status == '1'
                                  ? 'New'
                                  : l.status == '2'
                                      ? 'Follow Up'
                                      : l.status == '3'
                                          ? 'Visit'
                                          : l.status == '4'
                                              ? 'Reservasi'
                                              : 'None');
                        },
                      )
                    : DataNotFound(),
          ],
        ),
      );
    }

    Widget omset() {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        margin: EdgeInsets.only(
          top: 20,
          right: hMargin,
          left: hMargin,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [shadow],
        ),
        child: Row(
          children: [
            DividerVertical(
              height: 60,
            ),
            Container(
              width: 285,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderCard(
                    text: "KETERANGAN",
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      omsetC == null
                          ? 'Rp. 0'
                          : "Rp. ${price.format(int.parse(omsetC!))}",
                      style: blueTextStyle.copyWith(
                        fontSize: 26,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: isLoading
            ? Loading()
            : ListView(
                children: [
                  header(),
                  omset(),
                  countCard(),
                  leadCard(),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
      ),
    );
  }
}
