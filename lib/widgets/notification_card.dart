import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onTap;

  const NotificationCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          top: 20,
          left: hMargin,
          right: hMargin,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(dRadius),
          boxShadow: [shadow],
        ),
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(dRadius),
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: kWhiteColor,
                size: 20,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: blackTextStyle,
                  ),
                  Text(
                    subtitle,
                    style: greyTextStyle,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: kPrimaryColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
