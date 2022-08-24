import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final Function() onProfileTap;
  final Function() onImageTap;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.onProfileTap,
    required this.onImageTap,
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
          GestureDetector(
            onTap: onImageTap,
            child: Container(
              width: 80,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dRadius),
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: onProfileTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: blackTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  email,
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
