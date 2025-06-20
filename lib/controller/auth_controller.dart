import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:physioapp/exceptions/auth_exception.dart';

class AuthController with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expireToken;

  bool get isAuth {
    final bool isValid = _expireToken?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get uid => isAuth ? _uid : null;

  // Método de autenticação
  Future<void> _authenticate({
    required String email,
    required String password,
    required String urlFragment,
  }) async {
    final String _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyDfmSm9hXz8Dz1qJdvdwh4dwjqTJEo86w0';

    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthExceptions(error: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['e-mail'];
      _uid = body['localId'];
      _expireToken = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );

      notifyListeners();
    }
  }

  // Método Signup
  Future<void> signup({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlFragment: 'signUp');
  }

  // Método Signin
  Future<void> signin({required String email, required String password}) async {
    return _authenticate(
        email: email, password: password, urlFragment: 'signInWithPassword');
  }
}
