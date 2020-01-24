import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController(text: "200");

  ImageProvider myImageProvider = NetworkImage(
      "https://www.nomadfoods.com/wp-content/uploads/2018/08/placeholder-1-e1533569576673-960x960.png");

  void press() {
    print(myController.text);
    setCat();
  }

  void setCat() async {
    var image = await requestCat(myController.text);
    setState(() {
      myImageProvider = image;
    });
  }

  Future<MemoryImage> requestCat(String code) async {
    var client = http.Client();
    try {
      return await client
          .get("https://http.cat/$code")
          .then((it) => MemoryImage(it.bodyBytes));
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            TextField(
              controller: myController,
            ),
            RaisedButton(
              child: Text('Get a cat'),
              onPressed: press,
            ),
            Image(
              image: myImageProvider,
            )
          ])),
    );
  }
}
