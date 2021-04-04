import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/keys.dart';

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
