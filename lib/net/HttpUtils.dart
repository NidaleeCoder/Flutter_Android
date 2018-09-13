
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class HttpUtils{

  static Future<String> get(String url,String params) async{
    Dio dio = new Dio();
    Response response;
    if(params == null){
      response = await dio.get(url);
    }else{
      response = await dio.get(url,data: jsonDecode(params));
    }
    var responseJson = response.data["data"];
    return jsonEncode(responseJson);
  }

}