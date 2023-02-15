import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';



void main() async{
  runApp(
      MaterialApp(
        home:MyApp(),

      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // mbti 선택 시작
  final MBTI = ["MBTI",'ISTJ','ISTP','INFJ','INTJ','ISFJ','ISFP','INFP','INTP','ESTJ','ESFP','ENFP','ENTP','ESFJ','ESTP','ENFJ','ENTJ'];
  var selectedMBTI = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMBTI = MBTI[0];
      // _selectedAge = _Age[0];
    });
  }

  // mbti 선택 마지막
  //날짜 선택
  var selectedDate;
  void _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      String getToday(){
        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('yyyy.MM.dd');
        var strToday = formatter.format(value!);
        return strToday;
      }
      selectedDate = getToday();
    });
  }

  var UserImagePath;
  List<String> userImagePaths =[];


  var resultImage;

  getDate()async{
    var url2 =await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var data =await jsonDecode(url2.body);


    setState(() {
      resultImage = data;
      print(resultImage);
    });

  }

  final urlImages= [
    'https://t1.daumcdn.net/news/202210/04/kukinews/20221004152604048swko.jpg',
    'https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202301/15/mydaily/20230115054859216prji.jpg',

  ];



//여기부터 메인 홈페이지 시작
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('alpha finder'),
          actions:[
            IconButton(onPressed: ()async{
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.camera);

              if(image != null){
                UserImagePath = File(image.path);
                userImagePaths.add(UserImagePath.path);

                // var formData = FormData.fromMap({'image': await MultipartFile.fromFile(userImage)});



              }
            }, icon: Icon(Icons.camera_alt_outlined)),

            IconButton(onPressed: ()async{
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null){
                UserImagePath = File(image.path);
                userImagePaths.add(UserImagePath.path);
              }
            }, icon: Icon(Icons.photo_album_outlined))]),





      body: Container(
        color:Colors.black38,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children:[
            SizedBox(height:30),
            CarouselSlider( //메인 개발자 결과 슬라이드로 보여주기
              options: CarouselOptions(height: 400.0),
              items: urlImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.blue
                      ),
                      child: Image.network(i),
                    );
                  },
                );
              }).toList(),
            ),


            // 어플 예시 사진



            SizedBox(height: 50),
            //날짜 버튼
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                Container(color: Colors.deepPurple.shade50,height: 75,width: 150,
                    child:MaterialButton(onPressed:_showDatePicker,
                        child:Padding(padding: EdgeInsets.all(0.0),
                            child: Text("Your Age",style:TextStyle(color:Colors.black,fontSize: 25))))),
                //mbti 버튼
                Container(color: Colors.green,width: 150,
                    child:Column(mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text("Your MBTI",style:TextStyle(color: Colors.black,fontSize: 25)),
                          DropdownButton(style:TextStyle(fontSize: 25,color: Colors.black,),
                              value: selectedMBTI, items: MBTI.map((value)
                              {return DropdownMenuItem(
                                  value:value,
                                  child: Text(value));
                              }).toList(),onChanged: (value){setState(() {selectedMBTI = value!;});})])),
              ],
            ),

            SizedBox(height: 50),


            Container(
              color: Colors.brown,width: 170,
              child:MaterialButton(onPressed:()async{
                if((selectedMBTI!=null) & (selectedDate != null) & (selectedMBTI != MBTI[0]) &(UserImagePath != null) ){
                  // 테스트 끝나면 지울껏들
                  print("정상");
                  print(selectedMBTI);
                  print(selectedDate);
                  print(UserImagePath);
                  //끝

                  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
                  //요청에 이미지 파일 추가



                  final response = await http.post(url,
                      headers: <String, String>{
                        'Content-Type':'application/json; charset=UTF-8',
                      },
                      body: jsonEncode({"userImage":'$UserImagePath',"mbti":'$selectedMBTI','age':'$selectedDate'}));



                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');


                  await getDate();

                  Navigator.push(context,
                      MaterialPageRoute(builder:(c){
                        return ResultPage(resultImage:resultImage);}));


                }else //입력 안한경우 팝업창
                  showDialog(context: context, builder: (context){
                    return Dialog(child:Text('반드시 당신의 MBTI,생년월일,사진을 선택해주세요'));
                  });


              },
                  child:Padding(padding: EdgeInsets.all(20.0),
                    child: Text("시작하기",style: TextStyle(fontSize: 25)),)),
            ),
            Container(child: TextButton(onPressed: (){
              getDate();

              print(UserImagePath);
            },child: Text('check'),

            ),),],),

      ),);}}





class ResultPage extends StatelessWidget {
  ResultPage({Key? key, this.resultImage}) : super(key: key);
  final resultImage;
  final controller = ScreenshotController();


  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
          appBar: AppBar(),
          body: Container(color: Colors.yellow,
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [
              SizedBox(height: 40,),
              Container(color: Colors.cyanAccent, width: 300, height: 300,

                  child: Image.network(resultImage[0]['image'])),

              SizedBox(height: 40,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(width: 100, height: 100, color: Colors.deepPurple,),
                  Container(width: 100, height: 100, color: Colors.deepPurple,),
                ],),
              SizedBox(height: 40,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(width: 100, height: 100, color: Colors.deepPurple,),
                  Container(width: 100, height: 100, color: Colors.deepPurple,),
                ],),
              SizedBox(height: 25,),
              Container(height: 100, width: 100, color: Colors.cyan,
                child: IconButton(onPressed: () async {
                  final screenImage = await controller.capture();
                  saveAndShare(screenImage!);
                }, icon: Icon(Icons.share_outlined)),)
            ]),)
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final dicectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${dicectory.path}/flutter.png');
    screenImage.writeAsBytesSync(bytes);
    await Share.shareFiles([screenImage.path]);
  }
}
