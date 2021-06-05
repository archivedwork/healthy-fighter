import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/BL/P.dart';
import 'package:mobile/BL/Tools.dart';
import 'package:mobile/BL/designCourseAppTheme.dart';
import 'package:mobile/Models/CategoryItems/category.dart';
import 'package:transparent_image/transparent_image.dart';

class CourseInfoScreen extends StatefulWidget {
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  var opacity1 = 0.0;
  var opacity2 = 0.0;
  var opacity3 = 0.0;

  List items = ["Vitamine C,K", "1.58g Proten", "Prostate Cancer", "7g Carb"];

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
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
    String imagePath = P.globalUrlImage;
    final tempHight = (MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.6) +
        24.0);
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // AspectRatio(
                //   aspectRatio: 1.2,
                //   child: Image.network(
                //     P.globalUrlImage,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Stack(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: kTransparentImage,
                        image: imagePath == null
                            ? "https://flutter.dev/images/catalog-widget-placeholder.png"
                            : P.globalUrlImage,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.6) - 26.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: infoHeight,
                      maxHeight:
                          tempHight > infoHeight ? tempHight : infoHeight),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //! title
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 18, right: 16),
                        child: Text(
                          P.globalName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.darkerText,
                          ),
                        ),
                      ),

                      //! items
                      new AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: opacity3,
                          child: buildExpandedItems(P.globalItems)),
                      //! description
                      buildDescription(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 20),
                        child: new Align(
                            alignment: Alignment.centerLeft,
                            child: new Text(P.globalAddedBy)),
                      ),
                      // Expanded(
                      //   child: AnimatedOpacity(
                      //     duration: Duration(milliseconds: 500),
                      //     opacity: opacity2,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //           left: 16, right: 16, top: 8, bottom: 8),
                      //       child: Text(
                      //         "Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.",
                      //         textAlign: TextAlign.justify,
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.w200,
                      //           fontSize: 14,
                      //           letterSpacing: 0.27,
                      //           color: DesignCourseAppTheme.grey,
                      //         ),
                      //         maxLines: 3,
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //! close button
                      buildAnimatedCloseBtn(context),
                    ],
                  ),
                ),
              ),
            ),
            //! back arrow
            buildBackArrow(context)
          ],
        ),
      ),
    );
  }

  Padding buildBackArrow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SizedBox(
        width: AppBar().preferredSize.height,
        height: AppBar().preferredSize.height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius:
                new BorderRadius.circular(AppBar().preferredSize.height),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
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

  Padding buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Text(
            P.globalDescription,
            style: new TextStyle(color: Colors.black),
          ),
          // new Text(
          //   "When it comes  to prostate cancer in particular tomatos may yet offer some health benifits many doctors beileve that tomato products and lycopone ,dont effect  all prostate cancers equally .but may instead help slow the grouth only of aggressive and late -stage  prostate tumers",
          //   style: new TextStyle(color: Colors.black),
          // )
        ),
      ),
    );
  }

  Padding buildExpandedItems(List items) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15),
      child: new StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: items.length,

        itemBuilder: (BuildContext context, int index) => new Container(
            // color: Colors.white,
            decoration: BoxDecoration(
              color: DesignCourseAppTheme.nearlyWhite,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 8.0),
              ],
            ),
            child: new Center(
              child: new Text(items[index]),
            )),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, 0.4), // index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
