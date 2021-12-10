import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/new_activity.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewActivity(),
      ],
    );
  }
}
