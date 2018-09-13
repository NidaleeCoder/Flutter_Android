import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///Web详情页

class DetailsWidget extends StatefulWidget {
  String _url;
  String _title;
  DetailsWidget(String url,String title) {
    this._url = url;
    this._title = title;
  }

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState(_url,_title);
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String _url;
  String _title;
  _DetailsWidgetState(String url,String title) {
    this._url = url;
    this._title = title;
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _url,
      withJavascript: false,
      withZoom: false,
      appBar: new AppBar(
        title: new Text(_title),
      ),);

  }
}
