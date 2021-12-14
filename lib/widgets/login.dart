import 'package:flutter/material.dart';
import '../models/send_login.dart';

class NewLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List textFieldsValue = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(32),
        color: Color.fromRGBO(253, 235, 201, 1),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
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
                  prefixIcon: Icon(Icons.info_outline),
                  hintText: 'Enter your Username',
                  labelText: 'Username*',
                  //onChanged: (val) => titleInput = val
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
                  prefixIcon: Icon(Icons.info_outline),
                  hintText: 'Enter your password',
                  labelText: 'Password*',
                  //onChanged: (val) => titleInput = val
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      sendLogin(
                              username: textFieldsValue[0],
                              password: textFieldsValue[1])
                          .then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Hello ' +
                                ' your message has been stored. \n' +
                                'Your message was this: \n'),
                          ),
                        ),
                      );
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
      ),
    );
  }
}
