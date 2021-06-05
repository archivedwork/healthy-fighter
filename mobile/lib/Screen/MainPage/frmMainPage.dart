import 'dart:convert';
import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/BL/ColorLoader2.dart';
import 'package:mobile/BL/P.dart';
import 'package:mobile/BL/Tools.dart';
import 'package:mobile/Models/API/productAPI.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int currentIndex = 0;
  PageController _c;

  //! Variables Area ------------------------------------------------------------
  Future<List<Product>> productNaturalFuture;
  Future<List<Product>> productVitaminsFuture;

  List<Product> productList = [];

  //! -----------------------------------------------------------------------------

  //! get Product info from api with filtered ---------------------------------
  Future<List<Product>> _getProductInfoByFoodType(String foodType) async {
    List<Product> productList1 = [];

    var connectivityStatus = await checkConnection();
    if (connectivityStatus == false) {
      Fluttertoast.showToast(
          msg: "خطأ في الاتصال في الانترنت حاول مرة اخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 14.0);
      return productList1;
    }

    var response1 = await http.get(Uri.encodeFull(P.apiUrl), headers: {
      "Accept": "application/json",
      HttpHeaders.acceptCharsetHeader: 'utf-8'
    });

// try {
//     http.Response response = await http.get(url);
//     if (response.statusCode == 200) {
//       print(object) {"success": json.decode(response.body)};
//     }
//     // Bad Request
//     else if (response.statusCode == 400) {
//       return {"error": "Bad request"};
//     } else if (response.statusCode == 401) {
//       return {"error": "Unauthorized"};
//     }
//   } on Exception {
//     return {"error": "Some exception"};
//   }
//   setState(() {});

    // var connectivityStatus = await checkConnection();
    // if (connectivityStatus == false) {
    //   Fluttertoast.showToast(
    //       msg: "خطأ في الاتصال في الانترنت حاول مرة اخرى",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 2,
    //       backgroundColor: Colors.redAccent,
    //       textColor: Colors.white,
    //       fontSize: 14.0);
    //   return productList1;

    // }

    var exctractdata = json.decode(utf8.decode(response1.bodyBytes));
    // data = exctractdata["myinfo"];
    for (var post in exctractdata) {
      // print(post["addedBy"]["name"]);
      if (post["productType"] == foodType) {
        productList1.add(Product.fromJson(post));
      }
    }
    // print(productList[0].addedBy.email);
    return productList1;
  }
  //!----------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _getProductInfoByFoodType("VITAMINS");
    retriveData();
    _c = new PageController(
      initialPage: currentIndex,
    );
  }

  void retriveData() async {
    var connectivityStatus = await checkConnection();
    if (connectivityStatus == false) {
      Fluttertoast.showToast(
          msg: "خطأ في الاتصال في الانترنت حاول مرة اخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }
    productNaturalFuture = _getProductInfoByFoodType("NATURAL_FOOD");
    productVitaminsFuture = _getProductInfoByFoodType("VITAMIN");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: buildBottomNavyBarItems(),
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "Healthy Fighter",
          ),
        ),
        drawer: new Drawer(
          elevation: 0.0,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                height: 120,
                child: new Image.asset(
                  "assets/pics/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              new InkWell(
                  onTap: () {
                    setState(() {
                      _c.jumpToPage(1);
                      Navigator.pop(context);
                    });
                  },
                  child: buildListTile("Natural Foods", Icons.local_parking)),
              new InkWell(
                onTap: () {
                  setState(() {
                    _c.jumpToPage(2);
                    Navigator.pop(context);
                  });
                },
                child: buildListTile("Vitamins Products", Icons.fastfood),
              ),
              new Divider(),
              // buildListTile("Suggest New", Icons.thumb_up),
              new InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/MyteamPage");
                  },
                  child: buildListTile("Team", Icons.supervised_user_circle)),
              new InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/MyAboutPage");
                  },
                  child: buildListTile("About App", Icons.apps)),
              new InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/MyLicensePage");
                  },
                  child: buildListTile("License", Icons.comment)),
              buildBottomTextDrawer()
            ],
          ),
        ),
        body: new PageView(
          controller: _c,
          onPageChanged: (newPage) {
            setState(() {
              this.currentIndex = newPage;
            });
          },
          children: <Widget>[
            buildMainTab(),

            buildFutureProductWithRefresh("NATURAL_FOOD"),
            buildFutureProductWithRefresh("VITAMIN"),

            // buildFutureProduct(productNaturalFuture, "NATURAL_FOOD"),
            // buildFutureProduct(productVitaminsFuture, "VITAMIN"),

            // buildNaturalFoodsTab(),
            // buildVitaminsTab(),
            // new Text("suggest page here"),
          ],
        ));
  }

  FutureBuilder<List<Product>> buildFutureProductWithRefresh(String foodType) {
    return new FutureBuilder(
      future: foodType == "NATURAL_FOOD"
          ? productNaturalFuture
          : productVitaminsFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return new RefreshIndicator(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Product post = snapshot.data[index];

                return new InkWell(
                  onTap: () async {
                    P.globalItems = [];
                    P.globalItems.add(post.vitamine == null
                        ? "No data"
                        : "Vitamine " + post.vitamine.toString());
                    P.globalItems.add(post.protein == null
                        ? "No Data"
                        : post.protein.toString() + " Proten");
                    P.globalItems.add(post.carb == null
                        ? "No Data"
                        : post.carb.toString() + " Carb");
                    P.globalItems.add(
                        post.fight == null ? "No Data" : post.fight.toString());
                    P.globalAddedBy = post.addedBy.name == null
                        ? "No data"
                        : post.addedBy.name;
                    P.globalDescription = post.description == null
                        ? "No Description found"
                        : post.description;
                    P.globalUrlImage = post.link;
                    P.globalName = post.name;
                    // print(P.globalUrlImage);

                    goToDetailsItem();
                  },
                  child: buildContainerItemAPI(post.name, post.link, 18),
                );
              },
            ),
            onRefresh: () {
              setState(() {
                foodType == "NATURAL_FOOD"
                    ? productNaturalFuture =
                        _getProductInfoByFoodType("NATURAL_FOOD")
                    : productVitaminsFuture =
                        _getProductInfoByFoodType("VITAMIN");
              });
              return Future.value();
            },
          );
        else if (snapshot.connectionState == ConnectionState.none)
          return Center(
            child: Container(
              color: Colors.redAccent,
              child: new FlatButton(
                onPressed: () {
                  setState(() {
                    foodType == "NATURAL_FOOD"
                        ? productNaturalFuture =
                            _getProductInfoByFoodType("NATURAL_FOOD")
                        : productVitaminsFuture =
                            _getProductInfoByFoodType("VITAMIN");
                  });
                },
                child: new Text(
                  "اعادة المحاولة",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        else
          return Center(
            child: new ColorLoader3(),
          );
      },
    );
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

//! main tab
  ListView buildMainTab() {
    return new ListView(
      children: <Widget>[
        // Container(
        //   height: 130,
        //   child: new Image.asset(
        //     "assets/pics/logo.png",
        //     fit: BoxFit.contain,
        //   ),
        // ),
        new InkWell(
          onTap: () {
            setState(() {
              _c.jumpToPage(1);
            });
          },
          child: buildContainerItem(
              "Natural Foods", "assets/pics/natural_foods.jpeg", 18),
        ),
        new InkWell(
            onTap: () {
              setState(() {
                _c.jumpToPage(2);
              });
            },
            child: buildContainerItem(
                "Vitamins Products", "assets/pics/Vitamins.jpg", 18)),
      ],
    );
  }

// //! for natural foods tab

//   ListView buildNaturalFoodsTab() {
//     return new ListView(
//       children: <Widget>[
//         new InkWell(
//             onTap: goToDetailsItem,
//             child: buildContainerItem("Tomato", "assets/pics/tomato.jpeg", 18)),
//         buildContainerItem("Vitamins Products", "assets/pics/brocly.jpeg", 18),
//         buildContainerItem("Garlic", "assets/pics/garlic.jpeg", 18)
//       ],
//     );
//   }

  // //! for vitamins tab
  // ListView buildVitaminsTab() {
  //   return new ListView(
  //     children: <Widget>[
  //       buildContainerItem("Vitamin A", "assets/pics/VA.jpeg", 18),
  //       // buildContainerItem("Vitamins Products", "assets/pics/brocly.jpeg", 18),
  //       // buildContainerItem("Garlic", "assets/pics/garlic.jpeg", 18)
  //     ],
  //   );
  // }

  //! go to details page
  void goToDetailsItem() {
    Navigator.pushNamed(context, "/CourseInfoScreen");
  }

  //! for bottom navigator
  BottomNavyBar buildBottomNavyBarItems() {
    return new BottomNavyBar(
      backgroundColor: HexColor("#7A7A7A"),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Main"),
            activeColor: Colors.white),
        BottomNavyBarItem(
            icon: Icon(Icons.local_parking),
            title: Text("Natural Foods"),
            activeColor: Colors.white),
        BottomNavyBarItem(
            icon: Icon(Icons.fastfood),
            title: Text("Vitamins"),
            activeColor: Colors.white),
        // BottomNavyBarItem(
        //     icon: Icon(Icons.wb_incandescent),
        //     title: Text("Suggest New"),
        //     activeColor: Colors.white),
      ],
      onItemSelected: (int value) {
        setState(() {
          currentIndex = value;

          _c.jumpToPage(currentIndex);
        });
      },
      showElevation: true,
      selectedIndex: currentIndex,
    );
  }

  Expanded buildBottomTextDrawer() {
    return new Expanded(
        child: new Align(
      alignment: Alignment.bottomCenter,
      child: new Text(
        "Copyright 2019-ELTE-IK",
        style: new TextStyle(fontSize: 11.0),
      ),
    ));
  }

  ListTile buildListTile(String title, IconData iconTitle) {
    return new ListTile(
      dense: false,
      leading: new Icon(
        iconTitle,
        // color: Colors.white,
      ),
      title: new Text(
        title,
        // style: new TextStyle(color: Colors.white),
      ),
    );
  }

//! container item with image in assets
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

  //! container item with image from net
  Container buildContainerItemAPI(
      String labelText, String imagePath, double fontSize) {
    return Container(
      color: Colors.white,
      height: 200,
      width: double.infinity,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // new Image.network(
          //     imagePath,
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //   ),
          Stack(
            children: [
              Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  placeholder: kTransparentImage,
                  image: imagePath == null
                      ? "https://flutter.dev/images/catalog-widget-placeholder.png"
                      : imagePath,
                ),
              ),
            ],
          ),
          Container(
              height: 40,
              color: Colors.grey.withOpacity(0.9),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: new Text(
                  labelText,
                  style: new TextStyle(fontSize: fontSize, color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
