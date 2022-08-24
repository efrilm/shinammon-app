import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';

class LoadingButton extends StatelessWidget {
  final double width;
  final Color? color;

  const LoadingButton({Key? key, this.width = double.infinity, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: color == null ? kPrimaryColor : color,
        borderRadius: BorderRadius.circular(dRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              color: kWhiteColor,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'Loading',
            style: whiteTextStyle,
          ),
        ],
      ),
    );
  }
}
