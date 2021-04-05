import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../api/keys.dart';

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiresAt;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId => _userId;

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
    print('login');
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
      final prefs = await SharedPreferences.getInstance();
      final encodedAuth = json.encode({
        'token': _token,
        'expiresAt': _expiresAt.toIso8601String(),
        'userId': _userId,
      });
      await prefs.setString('userData', encodedAuth);

      _autoLogOut();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    print('auto login');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final userData =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiresAt']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = userData['token'];
    _expiresAt = DateTime.parse(userData['expiresAt']);
    _userId = userData['userId'];

    notifyListeners();
    _autoLogOut();

    return true;
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

  void logOut() {
    _token = null;
    _expiresAt = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    notifyListeners();
    SharedPreferences.getInstance().then(
      (value) => value.clear(),
    );
  }

  void _autoLogOut() {
    final expireInSeconds = _expiresAt.difference(DateTime.now()).inSeconds;
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    _authTimer = Timer(Duration(seconds: expireInSeconds), logOut);
  }
}
