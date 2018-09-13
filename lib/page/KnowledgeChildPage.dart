import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nidalee/net/HttpUtils.dart';
import 'package:flutter_nidalee/net/UrlConstants.dart';

class KnowledgeChildWidget extends StatefulWidget {
  dynamic mData;

  KnowledgeChildWidget(dynamic data) {
    mData = data;
  }

  @override
  _KnowledgeWidgetState createState() => _KnowledgeWidgetState(mData);
}

class _KnowledgeWidgetState extends State<KnowledgeChildWidget>{
  dynamic mData;
  List<Tab> mTitleTab;
  List<Widget> mBodyTab;

  _KnowledgeWidgetState(dynamic data) {
    mData = data;
  }

  _initTitleTab() {
    mTitleTab = [];
    mBodyTab = [];
    for (var result in mData["children"]) {
      mTitleTab.add(new Tab(
        child: new Text(result['name']),
      ));
      mBodyTab.add(new KnowledgeListWidget(result['id']));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTitleTab();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: mData['children'].length,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(mData['name']),
            bottom: new TabBar(
              indicatorColor: Colors.white,
              tabs: mTitleTab,
              isScrollable: true,
            ),
          ),
          body: new TabBarView(children: mBodyTab),
        ));
  }

}

class KnowledgeListWidget extends StatefulWidget {
  int mId;

  KnowledgeListWidget(int id) {
    this.mId = id;
  }

  @override
  _KnowledgeListWidgetState createState() => _KnowledgeListWidgetState(mId);
}

class _KnowledgeListWidgetState extends State<KnowledgeListWidget> {
  int mId;
  List mDataList;

  _KnowledgeListWidgetState(int id) {
    this.mId = id;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getChildData();
  }

  @override
  Widget build(BuildContext context) {
    return mDataList == null
        ? CupertinoActivityIndicator()
        : ListView.builder(
            itemBuilder: (context, index) => _renderItem(index),
            itemCount: mDataList.length,
          );
  }

  Widget _renderItem(index) {
    return GestureDetector(
        onTap: () {},
        child: new Card(
          margin: EdgeInsets.all(6.0),
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "作者:" + mDataList[index]['author'],
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                    new Text(
                      mDataList[index]['niceDate'],
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: new Text(mDataList[index]['title']),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: new Text(mDataList[index]['superChapterName'],
                  style: TextStyle(color: Colors.green,fontSize: 16.0),),
                )
              ],
            ),
          ),
        ));
  }

  _getChildData() async {
    Map<String, int> params = {"cid": mId};
    HttpUtils.get(UrlConstants.URL_KNOWLEDGE_CHILD, jsonEncode(params))
        .then((resultStr) {
      var result = jsonDecode(resultStr);
      setState(() {
        mDataList = result['datas'];
      });
    });
  }
}
