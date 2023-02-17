import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
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
}class _MyAppState extends State<MyApp> {


  var UserImagePath;

  final urlImages= [
    'https://t1.daumcdn.net/news/202210/04/kukinews/20221004152604048swko.jpg',
    'https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202301/15/mydaily/20230115054859216prji.jpg',
  ];

  @override





//여기부터 메인 홈페이지 시작
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          actions: [
        IconButton(onPressed: ()async{

          var picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          //TO convert Xfile into file

          File file = File(image!.path);
          UserImagePath = file;
          print(UserImagePath);

          if(UserImagePath != null){
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return SelectPage(UserImagePath:UserImagePath);
            }));
          } else
            showDialog(context: context, builder: (context){
              return Dialog(child:Text('사진을 찍거나 또는 앨범에서 사진을 선택해주세요',textAlign:TextAlign.center,style: TextStyle(fontSize: 30),));
            });
          

        }, icon: Icon(Icons.camera_alt)),
        IconButton(onPressed: ()async{

          var picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          //TO convert Xfile into file

          File file = File(image!.path);
          UserImagePath = file;
          print(UserImagePath);


        }, icon: Icon(Icons.photo)),
      ],title: Text('Alpha-male')),
      body:ListView(children:[
        Center(child:
          Column(children:[
            SizedBox(height: 30,),
            Container(child: Text('3 Developer Test Image'),),

            SizedBox(height: 15,),
            ShowDeveloper(DvevloperImage: 'assets/wolf.png'),

            SizedBox(height: 10,),
            ShowDeveloper(DvevloperImage:'assets/wolf.png'),

            SizedBox(height: 10,),
            ShowDeveloper(DvevloperImage:'assets/wolf.png'),

          ]),)],


      ),
    bottomNavigationBar: BottomAppBar(child: Container(color: Colors.black,
      child: Text('\n"A man needs to be strong." - Alpha Male',style:
      TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center),
    ),height: 50),);
  }
}

class ShowDeveloper extends StatelessWidget {
  const ShowDeveloper({Key? key, this.DvevloperImage}) : super(key: key);

  final DvevloperImage;
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue,height:320,width: 350,child:
    Column(children:[

      Container(child: Image.asset(DvevloperImage,fit: BoxFit.fill),height: 250,width: 350,color: Colors.redAccent,),
      SizedBox(height: 10,),
      Row(children: [
        SizedBox(width: 23,),
        Container(height:50,width: 50,color: Colors.greenAccent,child: Text('무언가?')),
        SizedBox(width: 23,),
        Container(height:50,width: 100,color: Colors.greenAccent,child: Column( crossAxisAlignment: CrossAxisAlignment.start,children:[
          Container(height: 20,width: 40,color: Colors.white38,child: Text('text'),),
          SizedBox(height: 5,),
          Container(height: 20,width: 40,color: Colors.white38,child: Text('text'),),
        ],)),]),],));
  }
}





class SelectPage extends StatefulWidget {
  const SelectPage({Key? key,this.UserImagePath}) : super(key: key);
  final UserImagePath;

  @override
  State<SelectPage> createState() => _SelectPageState();
}
class _SelectPageState extends State<SelectPage> {

  final MBTI = ["MBTI",'ISTJ','ISTP','INFJ','INTJ','ISFJ','ISFP','INFP','INTP','ESTJ','ESFP','ENFP','ENTP','ESFJ','ESTP','ENFJ','ENTJ'];
  var selectedMBTI = '';

  var selectedDate;


  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMBTI=MBTI[0];
    });
  }


  Future PostData() async {

    List<int> imageBytes = widget.UserImagePath.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);


    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; sharset=UTF-8',
        }, //this. header is essential to send json data
        body: jsonEncode([
          {'user_img_url':base64Image,
            'cft_result':'',
            'age':selectedDate,
            'mbti':selectedMBTI,
            'created_at':nowTime(),
            'created_by':'Han'}
        ])
    );
    print(response.body);
    print(response.statusCode);
    // print(response.body);
  }


  var resultImage;

  getData()async{
    var url =await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var data =await jsonDecode(url.body);

    setState(() {
      resultImage = data;
    });
    print(resultImage);
  }



  nowTime(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy.MM.dd');
    var strToday = formatter.format(now!);
    return strToday;
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,actions: [
        TextButton(onPressed: ()async{

          if((selectedMBTI != null)&(selectedDate != null)&(selectedMBTI != MBTI[0])&(widget.UserImagePath != null))
          {
            await PostData();
            await getData();
            Navigator.push(context, MaterialPageRoute(builder: (c){
              return ResultPage(resultImage:resultImage);
            }));
          } else
            showDialog(context: context, builder: (context){
              return Dialog(child: Text('MBTI와 Brith를 입력해 주세요',style: TextStyle(fontSize: 20),textAlign: TextAlign.center),);
            });


        }, child: Text('분석',style: TextStyle(color: Colors.white,fontSize: 20),))]),
      body: Center(child: Column(children: [
        Expanded(flex:1,child:Container(height: 300,width: double.infinity,child:Image.file(widget.UserImagePath,fit: BoxFit.fill) ,),),
        Expanded(flex:1,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[

                Container(width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[400]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17,right: 0),
                    child: DropdownButton(
                      style: TextStyle(fontSize: 25 ,color: Colors.black),
                        value: selectedMBTI,
                        isExpanded: true,
                        items: MBTI.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(), onChanged: (value){setState(() {
                          selectedMBTI=value!;});}),
                  ),
                ),



                Container(width: 250,height:50,decoration:
                BoxDecoration(),child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey[400]),onPressed: (){



                  showDatePicker(context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                  ).then((value){
                    String getToday(){
                      DateTime now = DateTime.now();
                      DateFormat formatter = DateFormat('yyyy-MM-dd');
                      var strToday = formatter.format(value!);
                      return strToday;
                    }
                    selectedDate = getToday();
                  });




                }, child:Align(alignment: Alignment.centerLeft,child: Text('Brith',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black)),))),


                Container(width: 250,height:50 ,decoration: BoxDecoration(color: Colors.grey[300]),child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 0),
                  child: TextField(decoration: InputDecoration(labelText: '당신의 연봉 단위 만원'),),
                )),



               // 체크용
                TextButton(onPressed: (){
                  print(widget.UserImagePath);
                  print(selectedMBTI);
                  print(selectedDate);

                }, child: Text('체크'))


              ]),),

      ],)),


      bottomNavigationBar: BottomAppBar(child: Container(color: Colors.black,
        child: Text('\n"A man needs to be strong." - Alpha Male',style:
        TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center),
      ),height: 50),);
  }
}

class ResultPage extends StatelessWidget {



  ResultPage({Key? key,this.resultImage}) : super(key: key);

  final resultImage;
  final screencontrolloer = ScreenshotController();




  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screencontrolloer,
      child: Scaffold(
        appBar:AppBar(backgroundColor: Colors.black,leading: IconButton(onPressed: (){}, icon: Icon(Icons.home)),
            actions: [
              TextButton(onPressed: (){}, child: Text('저장',style: TextStyle(color:Colors.white,fontSize: 20),)),
              TextButton(onPressed: ()async{
                final screenImage = await screencontrolloer.capture();

                saveAndShare(screenImage!);








              }, child: Text('공유',style: TextStyle(color:Colors.white,fontSize: 20),)),
              TextButton(onPressed: (){




              }, child: Text('체크',style: TextStyle(color:Colors.white,fontSize: 20),)),
            ]),
        body: ListView(
          children: [
            Center(child: Column(children: [

              Container(width: double.infinity,height: 350,color: Colors.blue,),
              SizedBox(height: 10,),
              Container(alignment: Alignment.center,width: 300,height: 150,color: Colors.blue,child: Text('ResultClass Text',style: TextStyle(fontSize: 30),)),
              SizedBox(height: 10,),
              Container(width: 400,height: 150,color: Colors.blue,child: Text('Result Class Text',style: TextStyle(fontSize: 30),)),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

                Container(height: 150,width: 150,color: Colors.green,child: Text('userface'),),
                Container(height: 150,width: 150,color: Colors.redAccent,child: Text('class face'),),
              ]),
              SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

                Container(height: 150,width: 150,color: Colors.redAccent,child: Text('class face'),),
                Container(height: 150,width: 150,color: Colors.redAccent,child: Text('class face'),),
              ]),



            ]),)

          ],

        )



      ),
    );
  }
  Future saveAndShare(Uint8List bytes) async{
    final decectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${decectory.path}/flutter.png');
    screenImage.writeAsBytesSync(bytes);
    await Share.shareFiles([screenImage.path]);
  }

  Future saveFilePath(screenImage)async{
    final decectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${decectory.path}/flutter.png');
  }
}
