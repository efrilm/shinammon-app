import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class PickImageCard extends StatelessWidget {
  final Function() onTap;
  
  const PickImageCard({Key? key, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dRadius),
          border: Border.all(
            width: 2,
            color: kPrimaryColor,
          ),
        ),
        child: Icon(
          Icons.add_a_photo_outlined,
          color: kPrimaryColor,
          size: 32,
        ),
      ),
    );
  }
}
