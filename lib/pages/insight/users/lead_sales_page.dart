import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shinnamon/const.dart';
import 'package:shinnamon/pages/insight/users/main_markom_page.dart';
import 'package:shinnamon/pages/insight/users/main_sales_page.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/loading.dart';

class LeadSalesPage extends StatefulWidget {
  const LeadSalesPage({Key? key}) : super(key: key);

  @override
  _LeadSalesPageState createState() => _LeadSalesPageState();
}

class _LeadSalesPageState extends State<LeadSalesPage> {
  var isLoading = false;
  var isData = false;

  List<dynamic> list = [];
  String level = '1';

  Future<void> getUsers() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    final response = await http.get(Uri.parse(AppUrl.getUserByLevel +
        '?level=' +
        level +
        '&project_code=' +
        AppCode.project));
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        setState(() {
          list = data;
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Sales",
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
      body: isLoading
          ? Loading()
          : isData
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final l = list[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainSalesPage(l['id_user'])));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 15,
                          left: hMargin,
                          right: hMargin,
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          boxShadow: [
                            shadow,
                          ],
                          borderRadius: BorderRadius.circular(dRadius),
                        ),
                        padding:
                            EdgeInsets.only(top: 10, right: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 2,
                              height: 30,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              l['user_name'],
                              style: blackTextStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : DataNotFound(),
    );
  }
}
