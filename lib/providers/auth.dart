import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/keys.dart';

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiresAt;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiresAt != null &&
        _expiresAt.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate({
    @required Uri url,
    @required String email,
    @required String password,
  }) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseDecoded = json.decode(response.body);

      if (responseDecoded['error'] != null) {
        throw HttpException(responseDecoded['error']['message']);
      }

      _token = responseDecoded['idToken'];
      _expiresAt = DateTime.now().add(
        Duration(
          seconds: int.parse(responseDecoded['expiresIn']),
        ),
      );
      _userId = responseDecoded['localId'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    return _authenticate(
      url: Api.signUp(Keys.FIREBASE),
      email: email,
      password: password,
    );
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    return _authenticate(
      url: Api.logIn(Keys.FIREBASE),
      email: email,
      password: password,
    );
  }
}
