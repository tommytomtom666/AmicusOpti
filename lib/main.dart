import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/search_page.dart';
import '../widgets/homeScreen.dart';
import '../widgets/login.dart';
import '../widgets/send_comment.dart';
import 'theme/custom_theme.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    theme: CustomTheme.lightTheme,
    title: 'Navigation Basics',
    initialRoute: '/second',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyApp(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => NewLogin(),
      '/third': (context) => UserComment(),
      '/four': (context) => SearchPage(),
    },
    //home: MyApp(),
  ));
  //runApp(MyApp());
}

//TODO: Activitat erstellen (Location)
//TODO: Nach Aktivitäten suchen (Wo, Wann, Was, Freie Plätze/Teilnehmer)
//TODO: Anmeldung auf Firebase?
//TODO:TestServer auf Heroko vorbereiten?