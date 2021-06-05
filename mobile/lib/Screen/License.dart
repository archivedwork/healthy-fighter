import 'package:flutter/material.dart';


class MyLicensePage extends StatefulWidget {
  @override
  _MyLicensePageState createState() => _MyLicensePageState();
}

class _MyLicensePageState extends State<MyLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("License"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Container(child: new Text("This application is a property of Eötvös Loránd Tudományegyetem Informatikai Kar as an autumn subject semester project"),),
          ),
          buildBottomTextDrawer()
        ],
      ),
      
    );
  }

   Expanded buildBottomTextDrawer() {
    return new Expanded(
        child: new Align(
      alignment: Alignment.bottomCenter,
      child: new Text(
        "Copyright 2019-ELTE-IK",
        // style: new TextStyle(fontSize: 11.0),
      ),
    ));
  }
}