import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        accentColor: Colors.blue.shade700,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shortcuts"),
      ),
      body: GridView.count(
        reverse: true,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        primary: true,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
        children: <Widget>[
          GestureDetector(
            onTap: () => _launchInWebViewOrVC("https://www.linkedin.com/feed/"),
              child: Container(
              margin: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/li.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>_launchInWebViewOrVC("https://www.instagram.com/"),
              child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:  AssetImage("images/insta.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>_launchInWebViewOrVC("https://open.spotify.com/playlist/37i9dQZF1ELVdVGVW8KilZ"),
              child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/sp.png"),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>_launchInWebViewOrVC("https://wa.me/905436496034"),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("images/wp.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
