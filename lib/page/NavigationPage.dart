import 'dart:async';

import 'package:flutter/material.dart';

class NavigationWidget extends StatefulWidget {
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  ScrollController _controller = new ScrollController();

  List _dataList = [];

  bool _isNeedLoadMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listAddData();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent && _isNeedLoadMore) {
        _loadmore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("热门导航"),
        ),
        body: new RefreshIndicator(
            color: Colors.redAccent,
            backgroundColor: Colors.green,
            child: new Center(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  if (position == _dataList.length) {
                    return new Text("加载");
                  } else {
                    return new Card(
                      child: new Container(
                        height: 80.0,
                        child: new Text("item：$position"),
                      ),
                    );
                  }
                },
                itemCount: _dataList.length + 1,
                controller: _controller,
              ),
            ),
            onRefresh: _refresh));
  }

  _listAddData() {
    _dataList = List.generate(20, (index) {});
  }

  Future<Null> _loadmore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _dataList.add(1);
        _dataList.add(1);
        _dataList.add(1);
        _dataList.add(1);
        _dataList.add(1);
      });
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      _dataList.clear();
      setState(() {
        _listAddData();
      });
    });
  }
}
