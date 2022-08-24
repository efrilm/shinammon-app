import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/absen_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/absen_card.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/loading.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  _AbsenPageState createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  var isLoading = false;
  var isData = false;

  List<Absen> list = [];
  List<dynamic> listToday = [];

  Future<void> getAbsen() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get(Uri.parse(AppUrl.getAbsen + "?project_code=" + AppCode.project));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        setState(() {
          for (Map i in data) {
            list.add(Absen.fromJson(i));
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

  Future<void> getToday() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
        Uri.parse(AppUrl.getAbsenToday + "?project_code=" + AppCode.project));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        setState(() {
          listToday = data;
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
    getAbsen();
    getToday();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          'Absensi',
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

    Widget tabBar() {
      Widget today() {
        return isLoading
            ? Loading()
            : isData
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: listToday.length,
                    itemBuilder: (context, i) {
                      final l = listToday[i];
                      return AbsenCard(
                        imageUrl: AppUrl.imgAbsenUrl + '/' + l['image'],
                        name: l['user_name'],
                        note: l['note'],
                        dateTime: l['date'],
                        status: l['status'] == '1' ? 'Absen' : 'Pamit',
                      );
                    },
                  )
                : DataNotFound();
      }

      Widget all() {
        return isLoading
            ? Loading()
            : isData
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final l = list[i];
                      return AbsenCard(
                        imageUrl: AppUrl.imgAbsenUrl + '/' + l.image,
                        name: l.userName,
                        note: l.note,
                        dateTime: l.date,
                        status: l.status == '1' ? 'Absen' : 'Pamit',
                      );
                    })
                : DataNotFound();
      }

      return DefaultTabController(
        length: 2,
        child: Container(
          margin: EdgeInsets.only(
            top: 30,
            left: hMargin,
            right: hMargin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(dRadius),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      color: kBlackColor.withOpacity(0.1),
                    ),
                  ],
                ),
                child: TabBar(
                  indicatorColor: kPrimaryColor,
                  labelStyle: blackTextStyle,
                  unselectedLabelColor: kGreyColor,
                  isScrollable: false,
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kPrimaryColor.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(dRadius),
                    color: kWhiteColor,
                  ),
                  tabs: [
                    Tab(
                      text: 'Hari Ini',
                    ),
                    Tab(
                      text: 'Semua',
                    ),
                  ],
                ),
              ),
              Container(
                height: double.maxFinite,
                child: TabBarView(
                  children: [
                    today(),
                    all(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            tabBar(),
          ],
        ),
      ),
    );
  }
}
