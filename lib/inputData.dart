import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
/// This is a paragraph of regular text.
///
/// This sentence has *two* _emphasized_ words (italics) and **two**
/// __strong__ ones (bold).
/// ```dart
/// var example = CodeBlockExample();
/// print(example.isItGreat); // "Yes."
/// ```
class MyCustomFormState extends State<MyCustomForm> {
  /// wiii
  final List textFieldsValue = [];
  Future<Album>? _futureAlbum;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.adjust_sharp),
              hintText: 'What do people call you?',
              labelText: 'User Name *',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              textFieldsValue.add(value);
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What do people call you?',
              labelText: 'User Name *',
            ),
            //onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
            //},
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          TextFormField(
              //controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                  labelText: "whatever you want",
                  hintText: "whatever you want",
                  icon: Icon(Icons.phone_iphone))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  print(textFieldsValue);
                  _futureAlbum = createAlbum(textFieldsValue[0]);
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/CompassData/'),
    //Uri.parse('http://127.0.0.1:8000/CompassData/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'project_text': title,
      'project_place': 'DEU_Stuttgart_IWEC',
      'author_email': 'thomas.weger@weger.it',
      'heating_price': 0.15,
      'cooling_price': 0.15,
      'electricity_price': 0.30,
      'indoor_room_temperature': 25,
      'supply_room_temperature': 22,
      'wrg_model': 'Plattentauscher',
      'wrg_massFlowIn': 5000,
      'wrg_massFlowExt': 5000,
      'wrg_efficiency': 70,
      'wrg_preassureDropIn': 200,
      'wrg_preassureDropExt': 200,
      'wrg_price': 5000
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
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
