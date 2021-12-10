import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../models/activity.dart';
import 'package:flutter/services.dart';

class NewActivity extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List textFieldsValue = [];
  //final String a_info_general;
  //final int a_attend_general;
  //final DateTime a_prep_time;
  //final DateTime a_pub_date;
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
                  hintText: 'Tell us more about your activity',
                  labelText: 'General Information *',
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
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Date'),
                //controller: amountControler,
                //onChanged: (val) => amountInput = val,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.teal,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.de);
                },
                child: Text(
                  'show date time picker (Chinese)',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextFormField(
                //controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
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
                  labelText: "Number of participants",
                  hintText: "whatever you want",
                  prefixIcon: Icon(Icons.people),
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
                      createActivity(
                              title_general: 'testData',
                              info_general: textFieldsValue[0],
                              attend_general: textFieldsValue[1])
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: Text('Hello ' +
                                      value.a_title_general +
                                      ' your message has been stored. \n' +
                                      'Your message was this: \n' +
                                      value.a_info_general))));
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
              TextButton(
                  onPressed: () {
                    //createActivity();
                    //print(titleControler.text);
                    //print(amountControler.text);
                  },
                  child: Text('Add Transaction'),
                  style: TextButton.styleFrom(primary: Colors.pink))
            ],
          ),
        ),
      ),
    );
  }
}
