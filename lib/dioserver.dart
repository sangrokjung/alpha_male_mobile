import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

const _API_PREFIX = "https://codingapple1.github.io/app/data.json";
class Server {
  Future<void> getReq() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX");


    print(response.data[0].toString());
    print(response.data[0]['image'].toString());



  }
  Future<void> postReq() async{
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(_API_PREFIX,data: {
          "Image":"image",
      "MBTI":"mbti",
      "Aga":"age"});
    print(response.data.toString());

  }
  Future<void> getReqWzQuery()async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get(_API_PREFIX,queryParameters:{
      "userId":1,
      "id":2
    });
    print(response.data.toString());
  }
}


Server server = Server();