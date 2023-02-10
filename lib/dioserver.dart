
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


// https://jsonplaceholder.typicode.com/posts
// https://codingapple1.github.io/app/data.json

const _API_PREFIX = 'https://codingapple1.github.io/app/data.json';
class Server {
  Server({Key? key,this.userImage,this.selectedMBTI,this.selectedDate,this.resultdata});
  final userImage;
  final selectedMBTI;
  final selectedDate;
  var resultdata;



  Future<void> getReq() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX");
    resultdata = response.data[0]['image'];
    // print(resultdata);




  }
  Future<void> postReq({required userImage, required selectedMBTI, required selectedDate}) async{
    Response response;
    Dio dio = new Dio();
    response = await dio
        .post(_API_PREFIX,data:{
      "userimage":'$userImage',
      "usermbti":"$selectedMBTI",
      "userage":"$selectedDate",

    });
    print(response.data.toString());

  }
}


Server server = Server();