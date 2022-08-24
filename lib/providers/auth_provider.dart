import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shinnamon/models/user_model.dart';
import 'package:shinnamon/services/api.dart';
import 'dart:convert';

import 'package:shinnamon/shared/user_preferences.dart';

enum Status {
  NotSignedIn,
  NotRegistered,
  SignedIn,
  Registered,
  Authenticating,
  Registering,
  SignOuted,
}

class AuthProvider with ChangeNotifier {
  Status _signedInStatus = Status.NotSignedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get signedInStatus => _signedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    var result;

    final Map<String, dynamic> signInData = {
      'email': email,
      'password': password,
    };

    _signedInStatus = Status.Authenticating;
    notifyListeners();
    Response response = await post(
      Uri.parse(AppUrl.signIn),
      body: jsonEncode(signInData),
      headers: {
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      var userData = responseData['data'];

      UserModel authUser = UserModel.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _signedInStatus = Status.SignedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser,
      };
    } else {
      _signedInStatus = Status.NotSignedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': jsonDecode(response.body)['error'],
      };
    }
    return result;
  }
}
