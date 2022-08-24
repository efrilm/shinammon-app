import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';

class RequestCard extends StatelessWidget {
  final Function() onTapDetail;
  final String name;
  final String date;
  final String source;
  final String note;
  final Function() onAccept;
  final String imageUrl;

  const RequestCard({
    Key? key,
    required this.onTapDetail,
    required this.name,
    required this.date,
    required this.source,
    required this.note,
    required this.onAccept,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapDetail,
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [shadow],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: hMargin,
                right: hMargin,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "16 Apr 2022 16:00:00",
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                    child: Text(
                      source,
                      style: primaryTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              margin: EdgeInsets.only(
                top: 10,
                left: hMargin,
                right: hMargin,
              ),
              decoration: BoxDecoration(
                color: kGreyLightColor,
                borderRadius: BorderRadius.circular(dRadius),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: hMargin,
                right: hMargin,
              ),
              child: Text(
                note,
                style: blackTextStyle.copyWith(),
              ),
            ),
            Container(
              width: double.infinity,
              height: 2,
              margin: EdgeInsets.only(
                top: 15,
                left: hMargin,
                right: hMargin,
              ),
              decoration: BoxDecoration(
                color: kGreyLightColor,
                borderRadius: BorderRadius.circular(dRadius),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: hMargin,
                right: hMargin,
                bottom: 10,
              ),
              child: CustomButton(
                onPressed: onAccept,
                text: "Terima",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
