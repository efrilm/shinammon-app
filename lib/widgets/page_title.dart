import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final bool isView;

  const PageTitle({
    Key? key,
    required this.title,
    this.onTap,
    this.isView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          isView
              ? GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text(
                        "Lihat Semua",
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: light,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
