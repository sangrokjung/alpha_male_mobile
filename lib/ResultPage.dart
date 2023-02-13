import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';



import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:dio/dio.dart';
// import './dioserver.dart';




class GetConForm extends StatefulWidget {
  GetConForm({Key? key}) : super(key: key);

  @override
  State<GetConForm> createState() => _GetConFormState();
}

class _GetConFormState extends State<GetConForm> {
  @override

  var resultImage;



  getDate()async{
    var url2 =await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var data =await jsonDecode(url2.body);

    setState(() {
      resultImage = data;
    });

  }

  Widget build(BuildContext context) {
    return Dialog(alignment: Alignment.center,
        child: Container(height: 150,width: 150,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children:[Text('결과를 확인하시겠습니까?',style: TextStyle(fontSize:20)),
                SizedBox(height: 15,),
                TextButton(onPressed: (){
                  print(resultImage);


                  }, child: Text('check')),

                TextButton(
                  onPressed:()async{
                    await getDate();


                    Navigator.push(context,
                        MaterialPageRoute(builder:(c){
                          return ResultPage(resultImage:resultImage);
                        }));
    }, child: Text('결과창으로'))]),) );
  }
}

class ResultPage extends StatelessWidget {
  ResultPage({Key? key,this.resultImage}) : super(key: key);
  final resultImage;

  var userImage;


  // String text = "";
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
          body:Container(height:double.infinity,width: double.infinity,color: Colors.green,
            child: Column(
              children: [
                Container(color: Colors.yellow,width: 300,height: 300,alignment: Alignment.bottomCenter,margin: EdgeInsets.all(70.0),
                    child:TextButton(onPressed: (){
                  print(resultImage[0]['image']);


                }, child: Text('경로확인'))),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Container(color: Colors.deepPurple,height: 100,width: 100,
                    child: Image.network(resultImage[0]['image']),),
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



