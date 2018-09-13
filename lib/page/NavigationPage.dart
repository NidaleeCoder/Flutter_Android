
import 'package:flutter/material.dart';

class NavigationWidget extends StatefulWidget {
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("热门导航"),
        ),
        body: Center(
          child: Text("热门导航"),
        ),
      ),
    );
  }
}
