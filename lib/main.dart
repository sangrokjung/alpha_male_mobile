import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http ;
import 'package:get/get.dart';

void main(){
  runApp(
      MaterialApp(
          home:MyApp()
      )
  );
}


class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);





  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final _MBTI = ["MBTI",'ISTJ','ISTP','INFJ','INTJ','ISFJ','ISFP','INFP','INTP','ESTJ','ESFP','ENFP','ENTP','ESFJ','ESTP','ENFJ','ENTJ'];
  String? _selectedMBTI = '';

  // final _Age = [
  //   '10','11','12','13','14','15','16','17','18','19','20',
  //   '21','22','23','24','25','26','27','28','29','30','31',
  //   '32','33','34','35','36','37','38','39','40','41','42',
  //   '43','44','45','46','47','48','49','50','51','52','53',
  //   '54','55','56','57','58','59','60'];
  // String _selectedAge = '';

  var userImage;
  var userAge = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedMBTI = _MBTI[0];
      // _selectedAge = _Age[0];
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(alignment: Alignment.center,
                  child: Text('alpha\nfinder',style:TextStyle(fontSize: 100),)),
              color: Colors.red,
            ),
            flex: 5,
          ),
          Expanded(child: Container(color: Colors.yellow,child: Text("Age와MBTI를 입력후\n다음 버튼을 눌러주세요",style: TextStyle(fontSize: 20),),alignment: Alignment.center),flex: 2),
          // Expanded(child: Container(color: Colors.cyanAccent),flex: 1),
          Expanded(child: Container(color: Colors.deepPurple.shade50,child: Text("Age와MBTI를 입력후\n다음 버튼을 눌러주세요",style: TextStyle(fontSize: 20),),alignment: Alignment.center),flex: 1),

          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(color: Colors.cyanAccent,


          ),


              Container(color: Colors.green,width: 100,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your MBTI"),
                    DropdownButton(
                      value: _selectedMBTI,
                      items: _MBTI.map(
                              (value){
                                return DropdownMenuItem(
                                  value:value,
                                  child: Text(value),
                                );
                              }
                              ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedMBTI = value;

                        });
                      },
                    ),
                  ],
                ),

              ),
            ],
          ),flex: 2),

          Expanded(
            child: Container(
              color: Colors.brown,
              alignment: Alignment.topCenter,
              child:TextButton(
                  onPressed:(){
                    print("확인");
                    print(_selectedMBTI);

                  },
                  child:Text("다음")),

              // color: Colors.green,
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

