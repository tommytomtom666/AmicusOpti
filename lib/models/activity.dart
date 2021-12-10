import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Activity> createActivity(
    {required String title_general,
    required String info_general,
    required String attend_general}) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/amicusOptiApp/postActivity/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'a_title_general': title_general,
      'a_info_general': info_general,
      'a_attend_general': attend_general,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Activity.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Activity {
  String a_title_general;
  String a_info_general;
  int a_attend_general;
  DateTime a_prep_time;
  DateTime a_pub_date;

  Activity({
    required this.a_title_general,
    required this.a_info_general,
    required this.a_attend_general,
    required this.a_prep_time,
    required this.a_pub_date,
  });

  factory Activity.fromJson(Map<dynamic, dynamic> json) {
    return Activity(
      a_title_general: json['a_title_general'],
      a_info_general: json['a_info_general'],
      a_attend_general: json['a_attend_general'],
      a_prep_time: json['a_prep_time'],
      a_pub_date: json['a_pub_date'],
    );
  }
}
