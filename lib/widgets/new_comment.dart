import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/send_comment_service.dart';
import 'dart:async';

// Create a Form widget.
class Comment extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List textFieldsValue = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Color.fromRGBO(253, 235, 201, 1),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 272,
                height: 184,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('/images/Lahomeoffice.png'),
                      fit: BoxFit.fitWidth),
                )),
            Text(
              'Comment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Crimson Text',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
            TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.5,
                  ),
                ),
                prefixIcon: Icon(Icons.person),
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.5,
                  ),
                ),
                prefixIcon: Icon(Icons.mail_outline),
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.5,
                  ),
                ),
                prefixIcon: Icon(Icons.text_fields_outlined),
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.5,
                      ),
                    ),
                    labelText: "A number",
                    hintText: "whatever you want",
                    prefixIcon: Icon(Icons.phone_iphone))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    createComment(
                            name: textFieldsValue[0],
                            email: textFieldsValue[1],
                            text: textFieldsValue[2])
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text('Hello ' +
                                    value.commentName +
                                    ' your message has been stored. \n' +
                                    'Your message was this: \n' +
                                    value.commentText))));
                    textFieldsValue.clear();
                    print('I was faster');
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Processing Data \u2705'),
                      duration: const Duration(milliseconds: 500),
                    ));
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
