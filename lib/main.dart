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
        accentColor: Colors.white70,
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
        children: ItemList.shortcuts,
      ),
    );
  }

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

  String _webUrl;
  String _shortName;
  bool autoControl = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Web & Url Shortcut"),
      ),
      floatingActionButton: Container(
        width: 100,
        height: 60,
        child: FloatingActionButton.extended(
          onPressed: () => saveShortcut(), 
          label: Text("Save"),
        ),
      ),
      body: Container(
        child: Form(
          key: formKey,
          autovalidate: autoControl,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hintText: "Add Url to launch",
                    labelText: "URL",
                  ),
                  keyboardType: TextInputType.url,
                  validator: (String s) => _urlControl(s),
                  onSaved: (deger) {
                  _webUrl = deger;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hintText: "Short Name",
                    labelText: "Short Name",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String s){},
                  onSaved: (deger) {
                    _shortName = deger;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _urlControl(String url) {
    Pattern pattern = r"((https?:www\.)|(https?:\/\/))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(url)) return 'Please control the URL or add https:// to start of url';
    else return null;
  }
  void saveShortcut(){
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      ItemList.shortcuts.add(
        UrlShortcutItem(_webUrl, _shortName, Colors.blue),
      );
    } else
    autoControl = true;
  }
}

class AddAppShortcut extends StatefulWidget {
  @override
  _AddAppShortcutState createState() => _AddAppShortcutState();
}

class _AddAppShortcutState extends State<AddAppShortcut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add App Shortcut"),
      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

class AddPhoneShortcut extends StatefulWidget {
  @override
  _AddPhoneShortcutState createState() => _AddPhoneShortcutState();
}

class _AddPhoneShortcutState extends State<AddPhoneShortcut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Phone Shortcut"),
      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

class UrlShortcutItem extends StatelessWidget {

  UrlShortcutItem( this._url, this._shortName, this.color);

  String _url;
  String _shortName;
  Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: ()=> launchUrl(),
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
        );
  }
  launchUrl() async {
    await launch(_url, headers: <String, String>{'my_header_key': 'my_header_value'},);
  }
}

class ItemList{
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
}