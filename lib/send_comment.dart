import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'send_comment_service.dart';
import 'dart:async';

// Create a Form widget.
class Comment extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List textFieldsValue = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'User Name *',
              ),
              onSaved: (value) {
                print('saved');
                textFieldsValue.add(value);
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value != null && value.contains('@')) {
                  return 'Do not use the @ char.';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.mail_outline),
                hintText: 'What is your mail?',
                labelText: 'User Mail *',
              ),
              //onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              //},
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                textFieldsValue.add(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.text_fields_outlined),
                hintText: 'What do you wanna tell us?',
                labelText: 'Enter here your comment',
              ),
              //onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              //},
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                textFieldsValue.add(value);
              },
            ),
            TextFormField(
                //controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    labelText: "A number",
                    hintText: "whatever you want",
                    icon: Icon(Icons.phone_iphone))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    createAlbum('placeholder').then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Hello' +
                                value.commentMail +
                                'your message has been stored.'))));
                    print('I was faster');
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
