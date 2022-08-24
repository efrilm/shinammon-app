import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinnamon/models/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', user.userId!);
    prefs.setString('name', user.name!);
    prefs.setString('email', user.email!);
    prefs.setString('phone', user.phone!);
    prefs.setString('level', user.level!);
    prefs.setString('projectCode', user.projectCode!);

    return prefs.commit();
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');
    String? level = prefs.getString('level');
    String? projectCode = prefs.getString('projectCode');
    return UserModel(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      level: level,
      projectCode: projectCode,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('level');
    prefs.remove('projectCode');
  }
}
