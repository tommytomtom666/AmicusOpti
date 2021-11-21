import 'package:flutter/material.dart';
import 'getData.dart';
import 'inputData.dart';
import 'widgets/styling_tapBox.dart';
import 'widgets/send_comment.dart';
import 'widgets/favourite.dart';
import 'widgets/styling_generalText.dart';
import 'widgets/styling_column.dart';
import 'routeDeath.dart';
import 'search_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String textSection =
      'Wir haben ein einfaches und doch leistungsfähiges Tool entwickelt zur Kalkulation der Lebenszykluskosten für ein Wärmerückgewinnungssystem. Sie möchten ihren ROI ermitteln? Sie möchten den Einfluss des Aufstellungsortes ermitteln? Verwenden Sie dazu unser Tool um den Einfluss auf Ihr HRS zu ermitteln. Probieren Sie unser kostenloses Tool aus. Es ist keine Anmeldung erforderlich.Verwenden Sie die Eingabemaske unten um die Daten Ihres Systems einzutragen. Auf dieser Basis wird unser Algorithmus die Lebenszykluskosten ermitteln.Sie sind nicht angemeldet \n some shit';
  String textSection2 = 'Feedback von Nutzern';

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'METEOR 2.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Use it for LCC calculation of HRS',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          FavoriteWidget()
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(color: color, icon: Icons.call, label: 'CALL'),
          buildButtonColumn(color: color, icon: Icons.near_me, label: 'CALL'),
          buildButtonColumn(color: color, icon: Icons.share, label: 'CALL'),
          ElevatedButton(
            child: const Text('Open route'),
            onPressed: () {
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => const SecondRoute()),
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
    );

    Widget myWebsite = Container(
        child: WebView(
      initialUrl: Uri.dataFromString(
              '<html><body><iframe src="https://www.youtube.com/embed/abc"></iframe></body></html>',
              mimeType: 'text/html')
          .toString(),
      javascriptMode: JavascriptMode.unrestricted,
    ));

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            GeneralText(textSection),
            Comment(),
            buttonSection,
            Container(
              padding: const EdgeInsets.all(32),
              child: TapboxA(),
            ),
            GeneralText(textSection2),
            MyProjects(),
            //myWebsite,
          ],
        ),
      ),
    );
  }
}
