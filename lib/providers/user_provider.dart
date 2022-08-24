import 'package:flutter/cupertino.dart';
import 'package:shinnamon/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = new UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
