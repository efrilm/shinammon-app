import 'package:flutter/material.dart';
import 'package:shinnamon/thema.dart';
import 'package:shinnamon/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          "Notification",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        children: [
          NotificationCard(
            title: 'Ada Lead Nih',
            subtitle: 'Segera Follow Up',
            onTap: () {},
          ),
          NotificationCard(
            title: 'Ada Lead Nih',
            subtitle: 'Segera Follow Up',
            onTap: () {},
          ),
          NotificationCard(
            title: 'Ada Lead Nih',
            subtitle: 'Segera Follow Up',
            onTap: () {},
          ),
          NotificationCard(
            title: 'Ada Lead Nih',
            subtitle: 'Segera Follow Up',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
