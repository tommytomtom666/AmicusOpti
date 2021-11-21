import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/CommentData/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'comment_name': title,
      'comment_mail': 'thomas.weger@weger.it',
      'comment_text': 'dddddddddddddddddd',
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String commentName;
  final String commentMail;
  final String commentText;

  Album(
      {required this.commentName,
      required this.commentMail,
      required this.commentText});

  factory Album.fromJson(Map<dynamic, dynamic> json) {
    return Album(
      commentName: json['comment_name'],
      commentMail: json['comment_mail'],
      commentText: json['comment_text'],
    );
  }
}
