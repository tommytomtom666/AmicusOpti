import 'package:flutter/material.dart';
import 'getData.dart';
import 'inputData.dart';
import 'styling_tapBox.dart';
import 'send_comment.dart';
import 'styling_generalText.dart';
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
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
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

    Widget tapBox = Container(
      padding: const EdgeInsets.all(32),
      child: TapboxA(),
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
            tapBox,
            GeneralText(textSection2),
            MyProjects(),
            //myWebsite,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

//A subclass of StatefulWidget that defines the widget.
//A subclass of State that contains the state for that widget and defines the widget’s build() method.

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  // #docregion _toggleFavorite
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
  // #enddocregion _toggleFavorite

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
