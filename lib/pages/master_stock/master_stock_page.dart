import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/const.dart';
import 'package:shinnamon/models/home_mode.dart';
import 'package:shinnamon/services/api.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/count_stock_card.dart';
import 'package:shinnamon/widgets/data_not_found.dart';
import 'package:shinnamon/widgets/loading.dart';
import 'package:shinnamon/widgets/page_title.dart';
import 'package:shinnamon/widgets/unit_card.dart';
import 'package:http/http.dart' as http;

class MasterStockPage extends StatefulWidget {
  const MasterStockPage({Key? key}) : super(key: key);

  @override
  _MasterStockPageState createState() => _MasterStockPageState();
}

class _MasterStockPageState extends State<MasterStockPage> {
  String level = '';

  getLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString('level')!;
    });
  }

  String? availableC;
  String? reservation;
  String? bookingC;
  String? soldC;

  bool isLoading = false;
  bool isData = false;

  getCount() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse(AppUrl.countHome + "?project_code=" + AppCode.project));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        availableC = data['available']['count'];
        reservation = data['reservation']['count'];
        bookingC = data['booking']['count'];
        soldC = data['sold']['count'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String? units;
  String? remainingUnits;

  getUnit() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.project + '?code=' + AppCode.project));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        units = data['data'][0]['units'];
        remainingUnits = data['data'][0]['remaining_units'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<dynamic> listAva = [];
  List<dynamic> listReserv = [];
  List<Home> listBooking = [];
  List<Home> listSold = [];
  String statusAva = '1';
  String statusReserv = '2';
  String statusBooking = '3';
  String statusSold = '4';
  String limit = '3';

  getAvailable() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(AppUrl.homeLimit +
        '?status=' +
        statusAva +
        '&project_code=' +
        AppCode.project));

    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          listAva = data;
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

  getReservation() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(AppUrl.homeLimit +
        '?status=' +
        statusReserv +
        '&project_code=' +
        AppCode.project));

    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          listReserv = data;
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

  getBoooking() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(AppUrl.homeLimit +
        '?status=' +
        statusBooking +
        '&project_code=' +
        AppCode.project));

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
            listBooking.add(Home.fromJson(i));
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

  getSold() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(AppUrl.homeLimit +
        '?status=' +
        statusSold +
        '&project_code=' +
        AppCode.project));

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
            listSold.add(Home.fromJson(i));
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
    getLevel();
    getCount();
    getAvailable();
    getReservation();
    getBoooking();
    getSold();
    getUnit();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Master Stock",
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

    Widget unit() {
      return Container(
        margin: EdgeInsets.only(
          left: hMargin,
          right: hMargin,
          top: 30,
        ),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [
            shadow,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    units == null ? 'N/A' : units!,
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    "Jumlah Unit",
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 1,
              height: 40,
              decoration: BoxDecoration(
                color: kGreyLightColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    remainingUnits == null ? 'N/A' : remainingUnits!,
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    "Sisa Unit",
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget count() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: hMargin,
          right: hMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CountStockCard(
              title: "Available",
              number: availableC == null ? 'N/A' : availableC!,
            ),
            CountStockCard(
              title: "Reservasi",
              number: reservation == null ? 'N/A' : reservation!,
            ),
            CountStockCard(
              title: "Booking",
              number: bookingC == null ? 'N/A' : bookingC!,
            ),
            CountStockCard(
              title: "Sold",
              number: soldC == null ? 'N/A' : soldC!,
            ),
          ],
        ),
      );
    }

    Widget divider() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        width: double.infinity,
        height: 2,
        decoration: BoxDecoration(
          color: kGreyLightColor,
        ),
      );
    }

    Widget available() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            PageTitle(
              title: "Tersedia",
              onTap: () {
                Navigator.pushNamed(context, '/available');
              },
            ),
            isLoading
                ? Loading()
                : isData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: listAva.length,
                        itemBuilder: (context, i) {
                          final l = listAva[i];
                          return UnitCard(
                            unit: l['no_home'],
                            typeUnit: l['type_home'],
                            onName: false,
                          );
                        })
                    : DataNotFound(),
          ],
        ),
      );
    }

    Widget reservasi() {
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
              title: "Reservasi",
              onTap: () {
                Navigator.pushNamed(context, '/reservasi');
              },
            ),
            isLoading
                ? Loading()
                : isData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: listReserv.length,
                        itemBuilder: (context, i) {
                          final l = listReserv[i];
                          return UnitCard(
                            unit: l['no_home'],
                            typeUnit: l['type_home'],
                            onName: false,
                          );
                        })
                    : DataNotFound(),
          ],
        ),
      );
    }

    Widget booking() {
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
              title: "Booking",
              onTap: () {
                Navigator.pushNamed(context, '/booking');
              },
            ),
            isLoading
                ? Loading()
                : isData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: listBooking.length,
                        itemBuilder: (context, i) {
                          final l = listBooking[i];
                          return UnitCard(
                            unit: l.noHome,
                            typeUnit: l.typeHome,
                            onName: false,
                          );
                        })
                    : DataNotFound(),
          ],
        ),
      );
    }

    Widget sold() {
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
              title: "Terjual",
              onTap: () {
                Navigator.pushNamed(context, '/sold');
              },
            ),
            isLoading
                ? Loading()
                : isData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: listSold.length,
                        itemBuilder: (context, i) {
                          final l = listSold[i];
                          return UnitCard(
                            unit: l.noHome,
                            typeUnit: l.typeHome,
                            onName: false,
                          );
                        })
                    : DataNotFound(),
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          level == '2'
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Berhasil di Tambah Kan!',
                      style: whiteTextStyle,
                    ),
                    backgroundColor: Colors.green[600],
                    duration: const Duration(milliseconds: 1500),
                    width: 200.0, // Width of the SnackBar.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, // Inner padding for SnackBar content.
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              : ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Hanya Markom Yang Bisa Menambahkan Unit!',
                      style: whiteTextStyle,
                    ),
                    backgroundColor: Colors.green[600],
                    duration: const Duration(milliseconds: 1500),
// Width of the SnackBar.
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, // Inner padding for SnackBar content.
                    ),
                  ),
                );
        },
        backgroundColor: kPrimaryColor,
      ),
      body: isLoading
          ? Loading()
          : ListView(
              children: [
                header(),
                unit(),
                count(),
                divider(),
                available(),
                reservasi(),
                booking(),
                sold(),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
    );
  }
}
