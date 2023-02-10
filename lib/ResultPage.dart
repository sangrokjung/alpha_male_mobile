import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import './dioserver.dart';




class GetConForm extends StatelessWidget {
  GetConForm({Key? key}) : super(key: key);
  @override

  

  Widget build(BuildContext context) {
    return Dialog(alignment: Alignment.center,
        child: Container(height: 150,width: 150,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children:[Text('결과를 확인하시겠습니까?',style: TextStyle(fontSize:20)),
                SizedBox(height: 15,),
                TextButton(
                  onPressed:()async{
                    await server.getReq();



                    Navigator.push(context,
                        MaterialPageRoute(builder:(c){
                          return ResultPage();
                        }));
    }, child: Text('결과창으로'))]),) );
  }
}

class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String text = "";
  String subject = "";
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
          body:Container(height:double.infinity,width: double.infinity,color: Colors.green,
            child: Column(
              children: [
                Container(color: Colors.yellow,width: 300,height: 300,alignment: Alignment.bottomCenter,margin: EdgeInsets.all(70.0),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Container(color: Colors.deepPurple,height: 100,width: 100,),
                  Container(color: Colors.deepPurple,height: 100,width: 100,),
                ]),
                SizedBox(height: 40,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Container(color: Colors.blue,height: 100,width: 100,),
                  Container(color: Colors.blue,height: 100,width: 100,),
                ],),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Container(width: 100,height: 100,color: Colors.amber,
                      child: TextButton(onPressed: ()async{
                        final screenImage = await controller.capture();

                        saveAndShare(screenImage!);
                      },child: Text(''))
                  )
                ],)
              ],
            ),

          )
      ),
    );

  }

  Future saveAndShare(Uint8List bytes) async{
    final dicectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${dicectory.path}/flutter.png');
    screenImage.writeAsBytesSync(bytes);
    await Share.shareFiles([screenImage.path]);
  }
}



