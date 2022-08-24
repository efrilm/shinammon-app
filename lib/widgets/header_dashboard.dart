import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/icon_card.dart';

class HeaderDashboard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String positions;

  const HeaderDashboard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.positions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        left: hMargin,
        right: hMargin,
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dRadius),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  positions,
                  style: greyTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ),
          IconCard(
            icon: Icons.notifications_outlined,
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
        ],
      ),
    );
  }
}
