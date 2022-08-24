import 'package:flutter/material.dart';
import 'package:shinnamon/models/user_model.dart';
import 'package:shinnamon/pages/sign_in_page.dart';
import 'package:shinnamon/shared/user_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUserData() => UserPreferences().getUser();

    return Scaffold(
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return Text('Erorr: ${snapshot.error}');
              else if (snapshot.data.email == null)
                return SignInPage();
              else
                UserPreferences().removeUser();
              return SignInPage();
          }
        },
      ),
    );
  }
}
