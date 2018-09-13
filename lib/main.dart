import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'page/RecommendPage.dart';
import 'page/KnowledgePage.dart';
import 'page/ProjectPage.dart';
import 'page/NavigationPage.dart';

void main() => runApp(
  new MaterialApp(
    theme: new ThemeData(
      primaryColor: Colors.green,
    ),
    home: new _HomeWidget()
  )
);

class _HomeWidget extends StatefulWidget {
  @override
  __HomeWidgetState createState() => __HomeWidgetState();
}

class __HomeWidgetState extends State<_HomeWidget> {

  var _currentIndex = 0;
  var _tabTitleList;
  var _tabImageList;
  var _body;

  @override
  void initState() {
    super.initState();
  }

  initData(){

    if(_tabTitleList == null){
      _tabTitleList = [
        '精彩推荐',
        '知识体系',
        '项目实战',
        '热门导航'
      ];
    }

    if(_tabImageList == null){
      _tabImageList = [
        const IconData(0xe867, fontFamily: 'MaterialIcons'),
        const IconData(0xe616, fontFamily: 'MaterialIcons'),
        const IconData(0xe2c8, fontFamily: 'MaterialIcons'),
        const IconData(0xe02f, fontFamily: 'MaterialIcons'),
      ];
    }

    _body = new IndexedStack(
      children: <Widget>[
        new RecommendWidget(),
        new KnowledgeWidget(),
        new ProjectWidget(),
        new NavigationWidget()
      ],
      index: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      body: _body,
      bottomNavigationBar: new CupertinoTabBar(
        activeColor: Colors.green,
        items: _getTabItems(),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getTabItems() {
    List<BottomNavigationBarItem> itemList = new List();
    for (int i = 0; i < 4; i++) {
      itemList.add(
          new BottomNavigationBarItem(
              icon: new Icon(_tabImageList[i],size: 22.0,),
              title: new Text(_tabTitleList[i],style: TextStyle(fontSize: 12.0),)));
    }
    return itemList;
  }
}
