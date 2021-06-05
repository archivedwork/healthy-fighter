import 'package:flutter/material.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("About App"),
      ),
      body: Column(
        children: <Widget>[
          new Image.asset("assets/pics/logo.png"),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
                    child: new Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                      "Healthy Fighter is a mobile application which helps giving hope to cancer patients by suggesting them what kind of natural foods are good for their health and fight by slowing cancer growing also, the app can suggest a vitamin products which also helps fighing cancer"),
                ),
              ),
            ),
          ),
         buildBottomText(),

        ],
      ),
    );
  }

  Expanded buildBottomText() {
    return Expanded(
          child: new Align(
        alignment: Alignment.bottomCenter,
        child: new Text(
      "app.healthyfighter@gmail.com",
       style: new TextStyle( fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
