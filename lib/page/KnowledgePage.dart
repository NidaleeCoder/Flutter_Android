import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nidalee/net/HttpUtils.dart';
import 'package:flutter_nidalee/net/UrlConstants.dart';

import 'KnowledgeChildPage.dart';

class KnowledgeWidget extends StatefulWidget {
  @override
  _KnowledgeWidgetState createState() => _KnowledgeWidgetState();
}

class _KnowledgeWidgetState extends State<KnowledgeWidget> {
  List _knowledgeData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getKnowledgeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("知识体系"),
      ),
      body: _knowledgeData == null
          ? new CupertinoActivityIndicator()
          : new ListView.builder(
              itemCount: _knowledgeData.length,
              itemBuilder: (context, position) =>
                  _renderItem(context, position)),
    );
  }

  Widget _renderItem(BuildContext context, int position) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new KnowledgeChildWidget(_knowledgeData[position])));
      },
      child: Card(
        margin: EdgeInsets.all(6.0),
        child: new Padding(
          padding: EdgeInsets.all(6.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                children: <Widget>[
                  new Text(
                    _knowledgeData[position]['name'],
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: new Text(
                        _getChildStr(_knowledgeData[position]['children'])),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )),
              new Icon(const IconData(0xe409,
                  fontFamily: 'MaterialIcons', matchTextDirection: true))
            ],
          ),
        ),
      ),
    );
  }

  String _getChildStr(List list) {
    String child = "";
    for (var reslut in list) {
      child += reslut['name'] + "  ";
    }
    return child;
  }

  _getKnowledgeData() {
    HttpUtils.get(UrlConstants.URL_KNOWLEDGE, null).then((resultStr) {
      var result = jsonDecode(resultStr);
      setState(() {
        _knowledgeData = result;
      });
    });
  }
}
