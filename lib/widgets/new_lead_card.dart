import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/divider_vertical.dart';

class NewLeadCard extends StatelessWidget {
  final String name;
  final String date;
  final Color? statusColor;
  final Function() onTap;
  final String status;

  const NewLeadCard({
    Key? key,
    required this.name,
    required this.date,
    this.statusColor,
    required this.onTap,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            DividerVertical(
              height: 30,
            ),
            SizedBox(
              width: 10,
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
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    date,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                status,
                style: primaryTextStyle.copyWith(
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
