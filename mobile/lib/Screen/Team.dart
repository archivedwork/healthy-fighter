import 'package:flutter/material.dart';
import 'package:mobile/BL/Tools.dart';
import 'package:mobile/BL/designCourseAppTheme.dart';

class MyteamPage extends StatefulWidget {
  @override
  _MyteamPageState createState() => _MyteamPageState();
}

class _MyteamPageState extends State<MyteamPage>  with TickerProviderStateMixin{

   final infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  var opacity1 = 0.0;
  var opacity2 = 0.0;
  var opacity3 = 0.0;




  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));

   setData();
  }

   void setData() async {
    animationController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Team"),
      ),
      body: Container(
        child: new ListView(
          children: <Widget>[
            buildCardTeam("Mohammed Jamal","Team Leader/DevOps","assets/pics/av1.png"),

            buildCardTeam("Latif Gulyiev","Backend Developer","assets/pics/av2.png"),
            buildCardTeam("Mohannad Jamal","Mobile Developer","assets/pics/av3.png"),
            buildCardTeam("Firas Bou Karroum","Full stack Developer","assets/pics/av4.png"),
            buildCardTeam("Baasansuren","Frontend Developer","assets/pics/av5.png"),
            buildCardTeam("Arnold Krisztián","External Expert","assets/pics/av6.png"),


            // buildAnimatedCloseBtn(context),
            



          ],
        ),
      ),
    );
  }

  Card buildCardTeam(String title , String subtitle,String imagePath) {
    return new Card(
            elevation: 0.0,
            child: new ListTile(
              leading: new Image.asset(imagePath),
              title: new Text(title),
              subtitle: new Text(subtitle),
            ),
          );
  }

    AnimatedOpacity buildAnimatedCloseBtn(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: opacity3,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: new InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: HexColor("#6DC122"),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: HexColor("#6DC122").withOpacity(0.5),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Center(
              child: Text(
                "Close",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.0,
                  color: DesignCourseAppTheme.nearlyWhite,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
