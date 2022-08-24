import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/no_data.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Tidak Ada Data",
            style: primaryTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
