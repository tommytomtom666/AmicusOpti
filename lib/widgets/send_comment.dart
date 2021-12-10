import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/new_comment.dart';

class UserComment extends StatefulWidget {
  const UserComment({Key? key}) : super(key: key);

  @override
  _UserCommentState createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Comment(),
      ],
    );
  }
}
