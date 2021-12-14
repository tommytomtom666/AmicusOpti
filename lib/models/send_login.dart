import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage.dart';

Future<receivedLogin> sendLogin(
    {required String username, required String password}) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api-token-auth/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    await storage.write(
        key: 'token',
        value: receivedLogin.fromJson(jsonDecode(response.body)).token);
    return receivedLogin.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get token');
  }
}

class receivedLogin {
  final String token;
  // Create storage

  receivedLogin({
    required this.token,
  });

  factory receivedLogin.fromJson(Map<dynamic, dynamic> json) {
    return receivedLogin(
      token: json['token'],
      // Write value
    );
  }
}
