import 'dart:convert';

import 'package:banner_view/banner_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nidalee/net/HttpUtils.dart';
import 'package:flutter_nidalee/net/UrlConstants.dart';
import 'DetailsPage.dart';

class RecommendWidget extends StatefulWidget {
  @override
  _RecommendWidgetState createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {
  List _listData = [];
  List _bannerData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerData();
    _getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("精彩推荐"),
        ),
        body: _listData.length == 0
            ? CupertinoActivityIndicator()
            : new ListView.builder(
                itemBuilder: (context, position) =>
                    _renderItem(context, position),
                itemCount: _listData.length,
              ));
  }

  Widget _renderItem(BuildContext context, int position) {
    if (position == 0) {
      return _renderBannerView();
    } else {
      return new GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new DetailsWidget(
                      _listData[position]['link'],
                      _listData[position]['title'])));
        },
        child: new Card(
          margin: EdgeInsets.all(8.0),
          child: new Padding(
            padding: EdgeInsets.all(6.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "作者 : " + _listData[position]["author"],
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    new Text(
                      _listData[position]["niceDate"],
                      style: TextStyle(color: Colors.black38),
                    )
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: new Text(_listData[position]["title"]),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: new Text(
                    _listData[position]["superChapterName"],
                    style: TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  List<Widget> _renderBannerItem() {
    List<Widget> list = [];
    if (_bannerData != null && _bannerData.length > 0) {
      for (var result in _bannerData) {
        list.add(Image.network(
          result["imagePath"],
          height: 200.0,
          fit: BoxFit.fill,
        ));
      }
    }
    return list;
  }

  Widget _renderBannerView() {
    return new Container(
      height: 200.0,
      child: new BannerView(
        _renderBannerItem(),
        intervalDuration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 900),
      ),
    );
  }

  ///获取Banner数据
  _getBannerData() async {
    HttpUtils.get(UrlConstants.URL_BANNER, null).then((resultStr) {
      var result = jsonDecode(resultStr);
      setState(() {
        _bannerData = result;
        _listData.add(_bannerData);
      });
    });
  }

  ///首页文章列表
  _getArticle() async {
    HttpUtils.get(UrlConstants.URL_ARTICLE, null).then((resultStr) {
      var result = jsonDecode(resultStr);
      setState(() {
        _listData.addAll(result['datas']);
      });
    });
  }
}
