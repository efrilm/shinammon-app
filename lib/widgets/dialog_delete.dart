import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/button_custom.dart';
import 'package:shinnamon/widgets/custom_button_outlined.dart';

class DialogDelete extends StatelessWidget {
  final Function() onYesTapped;
  const DialogDelete({Key? key, required this.onYesTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dRadius),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 2.5,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/delete.png'),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Apakah kamu yakin untuk menghapus',
              style: blackTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.5),
            Text(
              'Karena ini penghapusan permanen',
              style: greyTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: onYesTapped,
                  width: 100,
                  text: "Ya",
                ),
                CustomButtonOutlined(
                  text: "Tidak",
                  width: 100,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
