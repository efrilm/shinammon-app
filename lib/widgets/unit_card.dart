import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class UnitCard extends StatelessWidget {
  final String unit;
  final String typeUnit;
  final String? name;
  final bool onName;

  const UnitCard({
    Key? key,
    required this.unit,
    required this.typeUnit,
    this.name,
    this.onName = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          shadow,
        ],
        borderRadius: BorderRadius.circular(dRadius),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                unit,
                style: blackTextStyle,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                typeUnit,
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          onName
              ? Text(
                  name!,
                  style: greyTextStyle,
                )
              : Container(),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
