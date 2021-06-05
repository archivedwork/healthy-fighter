import 'package:flutter/material.dart';
import 'package:mobile/Screen/suggest/suggest.dart';

import 'BL/Tools.dart';
import 'Screen/About.dart';
import 'Screen/License.dart';
import 'Screen/MainPage/courseInfoScreen.dart';
import 'Screen/MainPage/frmDetailsItem.dart';

import 'Screen/MainPage/frmMainPage.dart';
import 'Screen/MainPage/frm_MainMaterial.dart';
import 'Screen/Team.dart';


void main() => runApp(new MaterialApp(
        home: MyMainPage(),
        theme: _testTheme,
         routes: <String, WidgetBuilder>{
          //  "/MyPage2": (BuildContext Context) => new MyPage2(),
           "/suggest": (BuildContext Context) => new SuggestPage(),
           "/MyDetailsItem": (BuildContext Context) => new MyDetailsItem(),
           "/CourseInfoScreen": (BuildContext Context) => new CourseInfoScreen(),
           "/MyLicensePage": (BuildContext Context) => new MyLicensePage(),
           "/MyteamPage": (BuildContext Context) => new MyteamPage(),
           "/MyAboutPage": (BuildContext Context) => new MyAboutPage()





         
         }
        
        ));



//for changing theme
var _testTheme = new ThemeData(
    //  primarySwatch: Colors.blue,
    primaryColor: HexColor("#7A7A7A"),
    // accentColor: HexColor("#71C329"),
    backgroundColor: Colors.white,

    //buttonColor: Colors.orange,
    fontFamily: "Cairo",
    brightness: Brightness.light);

