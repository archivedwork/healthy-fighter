import 'package:flutter/material.dart';
import 'package:mobile/BL/Tools.dart';
import 'package:mobile/BL/designCourseAppTheme.dart';


import 'categoryAllFoodsListView.dart';
import 'categoryListView.dart';





class MyMainMaterial extends StatefulWidget {
  @override
  _MyMainMaterialState createState() => _MyMainMaterialState();
}

class _MyMainMaterialState extends State<MyMainMaterial> {
  CategoryType categoryType = CategoryType.naturals;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xFFFFFFFF),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Column(
          children: <Widget>[
            new SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            new Expanded(
              child: new SingleChildScrollView(
                child: new Container(
                  height: MediaQuery.of(context).size.height,
                  child: new Column(
                    children: <Widget>[
                      getPopularCategoryUI(),
                      Flexible(child: getAllFoodsUI())
                     
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPopularCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            "Main Menu",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(
                  CategoryType.naturals, categoryType == CategoryType.naturals),
              SizedBox(width: 16),
              getButtonUI(
                  CategoryType.vitamins, categoryType == CategoryType.vitamins),
              SizedBox(width: 16),
              getButtonUI(
                  CategoryType.suggest, categoryType == CategoryType.suggest),
            ],
          ),
        ),
        SizedBox(height: 4),
         Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            "Popular Foods",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
               color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        CategoryListView(
          callBack: () {
            
            // moveTo();
          },
        ),
      ],
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    var txt = '';
    if (CategoryType.naturals == categoryTypeData) {
      txt = 'Natural Foods';
    } else if (CategoryType.vitamins == categoryTypeData) {
      txt = 'Vitamins';
    } else if (CategoryType.suggest == categoryTypeData) {
      txt = 'Suggest';
    }
    return Expanded(
      child: Container(
        decoration: new BoxDecoration(
            color: isSelected
                ?  HexColor("#7A7A7A") //Color(0xFF00B6F0)
                : Color(0xFFFFFFFF),
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            border: new Border.all(color:  HexColor("#7A7A7A"))),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.27,
                      color: isSelected
                          ? Color(0xFFFFFFFF)
                          :  HexColor("#7A7A7A") // Color(0xFF00B6F0),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only( left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Choose your",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    // color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  "Healthy Fighter",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    // color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: Image.asset('assets/pics/logo.png',fit: BoxFit.cover,),
          )
        ],
      ),
    );
  }

  Widget getAllFoodsUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Foods By Category",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
              // color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(child: MyAllFoodscategory())
        ],
      ),
    );
  }
}

enum CategoryType {
  naturals,
  vitamins,
  suggest,
}
