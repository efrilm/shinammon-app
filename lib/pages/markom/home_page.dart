import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/antrian_model.dart';
import 'package:shinnamon/models/lead_model.dart';
import 'package:shinnamon/pages/sales_page/detail_sales_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/antrian_card.dart';
import 'package:shinnamon/widgets/count_card.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/feature_card.dart';
import 'package:shinnamon/widgets/header_dashboard.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/new_lead_card.dart';
import 'package:shinnamon/widgets/page_title.dart';
import 'package:http/http.dart' as http;

class MHomePage extends StatefulWidget {
  const MHomePage({Key? key}) : super(key: key);

  @override
  _MHomePageState createState() => _MHomePageState();
}

class _MHomePageState extends State<MHomePage> {
  var isLoading = false;
  var isData = false;

  int value = 0;

  String userName = '';
  String image = '';

  List<Antrian> listAntrian = [];

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

  getAntrian() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.antrianLimit + AppCode.project));
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          isData = true;
          for (Map i in data) {
            listAntrian.add(Antrian.fromJson(i));
          }
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
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
    final response = await http.get(Uri.parse(AppUrl.countM +
        "?markom_id=" +
        pref.getString('userId')! +
        "&project_code=" +
        AppCode.project));
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

  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(AppUrl.leadLimitM +
          '?id=' +
          pref.getString('userId')! +
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

  setToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final status = await OneSignal.shared.getDeviceState();
    final response = await http.put(Uri.parse(AppUrl.setToken), body: {
      'id': pref.getString('userId'),
      'token': status?.userId,
    });
    print(pref.getString('userId'));
    print(status?.userId);    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getAntrian();
    getCount();
    getLead();
    setToken();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return HeaderDashboard(
        name: userName,
        imageUrl: AppUrl.imgProfileUrl + '/' + image,
        positions: "Markom",
      );
    }

    Widget countCard() {
      return CountCard(
        countOfDaily: daily == null ? 'N/A' : daily!,
        countOfWeekly: weekly == null ? 'N/A' : weekly!,
        countOfMonthly: monthly == null ? 'N/A' : monthly!,
      );
    }

    Widget feature() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FeatureCard(
              title: "Absen",
              icon: Icons.pan_tool_outlined,
              onTap: () {
                Navigator.pushNamed(context, '/add-absen');
              },
            ),
            FeatureCard(
              title: "Pamit",
              icon: Icons.group_work_outlined,
              onTap: () {
                Navigator.pushNamed(context, '/add-pamit');
              },
            ),
          ],
        ),
      );
    }

    Widget antrianSales() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            PageTitle(
              title: "Antrian Sales",
              onTap: () {
                Navigator.pushNamed(context, '/antrian');
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listAntrian.length,
              itemBuilder: (context, i) {
                final a = listAntrian[i];
                return AntrianCard(
                  name: a.nameUser!,
                  date: a.updateDate!,
                  imageUrl: AppUrl.imgProfileUrl + '/' + a.photo!,
                  onTap: () {},
                );
              },
            ),
          ],
        ),
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

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Loading()
            : ListView(
                children: [
                  header(),
                  countCard(),
                  feature(),
                  antrianSales(),
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
