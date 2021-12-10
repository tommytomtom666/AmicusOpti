import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Comment> createComment(
    {required String name, required String email, required String text}) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/amicusOptiApp/postData/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'c_name': name,
      'c_email': email,
      'c_text': text,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Comment.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Comment {
  final String commentName;
  final String commentMail;
  final String commentText;

  Comment(
      {required this.commentName,
      required this.commentMail,
      required this.commentText});

  factory Comment.fromJson(Map<dynamic, dynamic> json) {
    return Comment(
      commentName: json['c_name'],
      commentMail: json['c_email'],
      commentText: json['c_text'],
    );
  }
}
