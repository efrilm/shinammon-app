import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const SettingCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(dRadius),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: kWhiteColor,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: kGreyColor,
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kGreyLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
