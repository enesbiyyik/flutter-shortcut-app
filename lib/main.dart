import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcuts',
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
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => addNew(context)),
        ],
      ),
      body: GridView.count(
        reverse: true,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        primary: true,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        children: shortcuts,
      ),
    );
  }

  static List<Widget> shortcuts = [
    GestureDetector(
      onTap: () => DeviceApps.openApp("com.linkedin.android"),
      child: Container(
        margin: EdgeInsets.all(6),
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
      onTap: () => DeviceApps.openApp("com.instagram.android"),
      child: Container(
        margin: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/insta.png"),
          ),
        ),
      ),
    ),
    GestureDetector(
      onTap: () => DeviceApps.openApp("com.spotify.music"),
      child: Container(
        margin: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/sp.png"),
          ),
        ),
      ),
    ),
    GestureDetector(
      onTap: () => DeviceApps.openApp("com.whatsapp"),
      child: Container(
        margin: EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage("images/wp.png"),
          ),
        ),
      ),
    ),
  ];

  void addNew(BuildContext ctx) {
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          content: Container(
            height: 350,
            child: Column(
              children: [
                Container(
                  child: RaisedButton(
                    child: Text("Add Phone Shortcut"),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddPhoneShortcut())),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text("Add App Shortcut"),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddAppShortcut())),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    child: Text("Add Web Shortcut"),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddWebShortcut())),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ],
            ),
          )
        );
      }
    );
  }
}

class AddWebShortcut extends StatefulWidget {
  @override
  _AddWebShortcutState createState() => _AddWebShortcutState();
}

class _AddWebShortcutState extends State<AddWebShortcut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Web & Url Shortcut"),
      ),
    );
  }
}

class AddAppShortcut extends StatefulWidget {
  @override
  _AddAppShortcutState createState() => _AddAppShortcutState();
}

class _AddAppShortcutState extends State<AddAppShortcut> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AddPhoneShortcut extends StatefulWidget {
  @override
  _AddPhoneShortcutState createState() => _AddPhoneShortcutState();
}

class _AddPhoneShortcutState extends State<AddPhoneShortcut> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
