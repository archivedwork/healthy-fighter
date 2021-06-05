import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyDetailsItem extends StatefulWidget {
  @override
  _MyDetailsItemState createState() => _MyDetailsItemState();
}

class _MyDetailsItemState extends State<MyDetailsItem> {
  @override
  Widget build(BuildContext context) {
    List items = ["Vitamine C,K", "1.58g Proten", "Prostate Cancer", "7g Carb"];

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Tomato"),
        ),
        body: Column(
          children: <Widget>[
            buildContainerItem("Tomato", "assets/pics/tomato.jpeg", 18),
            buildExpandedItems(items),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text("Description")),
            ),
            buildDescription(),
            Padding(
              padding: const EdgeInsets.only(left : 15.0),
              child: new Align(
                alignment: Alignment.centerLeft,
                child: new Text("Kristain Arnold")),
            )
          ],
        ));
  }

  Padding buildDescription() {
    return Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Container(
              decoration:
                  new BoxDecoration(
                   border: new Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text(
                    "When it comes  to prostate cancer in particular tomatos may yet offer some health benifits many doctors beileve that tomato products and lycopone ,dont effect  all prostate cancers equally .but may instead help slow the grouth only of aggressive and late -stage  prostate tumers",
                    style: new TextStyle(color: Colors.black),),
              ),
            ),
          );
  }

  Padding buildExpandedItems(List items) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: new StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) => new Container(
            color: Colors.white,
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

  Container buildContainerItem(
      String labelText, String imagePath, double fontSize) {
    return Container(
      color: Colors.red,
      height: 200,
      width: double.infinity,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
              height: 40,
              color: Colors.white.withOpacity(0.7),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: new Text(
                  labelText,
                  style: new TextStyle(fontSize: fontSize),
                ),
              ))
        ],
      ),
    );
  }
}
