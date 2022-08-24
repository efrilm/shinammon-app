import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/antrian_model.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/antrian_card.dart';
import 'package:shinnamon/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shinnamon/widgets/loading.dart';

class AntrianPage extends StatefulWidget {
  const AntrianPage({Key? key}) : super(key: key);

  @override
  _AntrianPageState createState() => _AntrianPageState();
}

class _AntrianPageState extends State<AntrianPage> {
  List<Antrian> list = [];

  bool isLoading = false;
  bool isData = false;

  getAntrian() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.antrian + AppCode.project));
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
            list.add(Antrian.fromJson(i));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAntrian();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Booking",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: isLoading
          ? Loading()
          : ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final a = list[i];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: hMargin,
                  ),
                  child: AntrianCard(
                    onTap: () {},
                    name: a.nameUser!,
                    imageUrl: AppUrl.imgProfileUrl + '/' + a.photo!,
                    date: a.updateDate!,
                  ),
                );
              },
            ),
    );
  }
}
