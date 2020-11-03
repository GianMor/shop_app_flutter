import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
=======

import 'package:http/http.dart' as http;
import 'dart:convert';
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445

import 'package:shop_app_flutter/models/http_exception.dart';

class Auth with ChangeNotifier {
<<<<<<< HEAD
  final key = 'AIzaSyAqtWulCGP9NZ48dIGGZCmuydrq_5kex3A';

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  String get userId => _userId;

  bool get isAuth => token != null;

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
=======
  String _token;
  DateTime _expiryDate;
  String _userId;
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAqtWulCGP9NZ48dIGGZCmuydrq_5kex3A';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
<<<<<<< HEAD
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
=======
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
<<<<<<< HEAD

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
=======
>>>>>>> c60f227dda59b984d8443e10f98c25acf25c6445
}
