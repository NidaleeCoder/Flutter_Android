import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nidalee/net/HttpUtils.dart';
import 'package:flutter_nidalee/net/UrlConstants.dart';

class ProjectWidget extends StatefulWidget {
  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  List<Tab> _tabList;
  List<Widget> _tabViewList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProjectTreeData();
  }

  @override
  Widget build(BuildContext context) {
    return _tabList == null
        ? CupertinoActivityIndicator()
        : DefaultTabController(
            length: _tabList.length,
            child: Scaffold(
                appBar: new AppBar(
                  title: new Text("项目实战"),
                  bottom: new TabBar(
                    indicatorColor: Colors.white,
                    tabs: _tabList,
                    isScrollable: true,
                  ),
                ),
                body: TabBarView(children: _tabViewList)));
  }

  _getProjectTreeData() {
    HttpUtils.get(UrlConstants.URL_PROJECT_TREE, null).then((resultStr) {
      var result = jsonDecode(resultStr);
      setState(() {
        _tabList = [];
        _tabViewList = [];
        for (var result in result) {
          _tabList.add(new Tab(text: result['name']));
          _tabViewList.add(new ProjectChildWidget(result['id']));
        }
      });
    });
  }
}

class ProjectChildWidget extends StatefulWidget {
  final _cid;

  ProjectChildWidget(this._cid);

  @override
  _ProjectChildWidgetState createState() => _ProjectChildWidgetState(_cid);
}

class _ProjectChildWidgetState extends State<ProjectChildWidget> {
  final _cid;
  List _childData;

  _ProjectChildWidgetState(this._cid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProjectChildData();
  }

  @override
  Widget build(BuildContext context) {
    return _childData == null
        ? new Container()
        : ListView.builder(
            itemBuilder: (context, index) => _renderItem(_childData[index]),
            itemCount: _childData.length,
          );
  }

  Widget _renderItem(var result) {
    return new Card(
      margin: EdgeInsets.all(8.0),
      child: new Padding(
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new Image.network(
              result['envelopePic'],
              height: 150.0,
              width: 100.0,
            ),
            new Expanded(
                child: new Container(
              height: 150.0,
              padding: EdgeInsets.only(left: 6.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 6.0),
                    child: new Text(
                      result['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    ),
                  ),
                  new Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: new Text(
                        result['desc'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                  new Expanded(
                      child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        result['author'],
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      new Text(result['niceDate'],
                          style: TextStyle(color: Colors.black45))
                    ],
                  ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  _getProjectChildData() {
    Map<String, int> params = {"cid": _cid};
    HttpUtils.get(UrlConstants.URL_PROJECT_LIST, jsonEncode(params))
        .then((resultStr) {
      setState(() {
        _childData = jsonDecode(resultStr)['datas'];
      });
    });
  }
}
