import 'dart:convert';

import 'package:flutter/material.dart';

import './ResultPage.dart';

import 'package:http/http.dart' as http;

// import './dioserver.dart';



//업로드 페이지
class UploadPage extends StatelessWidget {
  UploadPage({Key? key,this.selectedMBTI,this.selectedDate,this.userImage}) : super(key: key);
  var userImage;
  var selectedMBTI;
  var selectedDate;
  List<String> userImagePath = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.file(userImage),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                print(selectedMBTI);
                print(selectedDate);
                print(userImage);

                Navigator.pop(context);
              },child: Text('뒤로가기')),


              TextButton(onPressed: ()async{
                // await server.postReq(userImage:userImage,selectedMBTI:selectedMBTI,selectedDate:selectedDate);
                final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
                final response = await http.post(url,
                     headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body:jsonEncode({"userImage":'$userImage', 'mbti':'$selectedMBTI','age':'$selectedDate'}));
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                // mbti age image 전송(post) 해야함
                // 그리고 보낸 사진이 서버에서 처리 되어서 돌아오면 결과창을 띄어야함
                // 이 것들이 아니라면 로딩 아이콘을 띄워야함

                Navigator.push(context,
                    MaterialPageRoute(builder: (c){return GetConForm();}));
              },child: Text('이미지 업로드')),
            ],
          ),
        ],
      ),


    );
  }
}

