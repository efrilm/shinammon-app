import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class AbsenCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String note;
  final String dateTime;
  final String status;

  const AbsenCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.note,
    required this.dateTime,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(dRadius),
        boxShadow: [shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(dRadius),
              topRight: Radius.circular(dRadius),
            ),
            child: Image.network(imageUrl),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: RichText(
              text: TextSpan(
                text: name,
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
                children: [
                  TextSpan(
                    text: "  $note",
                    style: blackTextStyle.copyWith(fontWeight: light),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 4,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateTime,
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                Text(
                  status,
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 3,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(dRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
