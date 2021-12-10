import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//------------------------- Getting data ----------------------------------
class MyProjects extends StatefulWidget {
  MyProjects({Key? key}) : super(key: key);

  @override
  _MyProjectsState createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  late Future<Proj> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Proj>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.project_name);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

//https://stackoverflow.com/questions/54426802/what-does-mean-in-dart
Future<Proj> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/apiComments/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Proj.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Proj {
  final String project_name;
  final String project_mail;
  final String project_text;
  final String project_pub_date;

  Proj({
    required this.project_name,
    required this.project_mail,
    required this.project_text,
    required this.project_pub_date,
  });

  factory Proj.fromJson(Map<String, dynamic> json) {
    return Proj(
      project_name: json['c_name'],
      project_mail: json['c_email'],
      project_text: json['c_text'],
      project_pub_date: json['c_pub_date'],
    );
  }
}
