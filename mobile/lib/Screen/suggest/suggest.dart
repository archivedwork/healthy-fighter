import 'package:flutter/material.dart';

class SuggestPage extends StatefulWidget {
  @override
  _Suggestpage createState() => _Suggestpage();
}

class _Suggestpage extends State<SuggestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Fruits"),),
      body: new Container(
        width: 200,
        height: 800,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(top :40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: (){} ,
                child: buildTextlabel("hello"))//,
              //buildTextlabel("MO")
            ],
          ),
        ),
      ),
    );
  }

  Text buildTextlabel(String text) {
    return new Text(
            text,style: new TextStyle(fontSize: 18.0,color: Colors.white),
              
            );
  }
}