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
import 'package:gallery_saver/gallery_saver.dart';



void main() async{
  runApp(
      MaterialApp(
        home:MyApp(),
        theme:ThemeData(
          appBarTheme: AppBarTheme(color: Colors.black), fontFamily: "Castoro-Regular",
          textTheme: TextTheme(bodyText2: TextStyle(fontFamily: "Roboto-Regular"),),
          bottomAppBarTheme:BottomAppBarTheme(color: Colors.black),
          scaffoldBackgroundColor: Colors.black,


        ),
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}class _MyAppState extends State<MyApp> {
  var UserImagePath;



//여기부터 메인 홈페이지 시작
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

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

                if(UserImagePath != null){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return SelectPage(UserImagePath:UserImagePath);
                  }));
                } else
                  showDialog(context: context, builder: (context){
                    return Dialog(child:Text('사진을 찍거나 또는 앨범에서 사진을 선택해주세요',textAlign:TextAlign.center,style: TextStyle(fontSize: 30),));
                  });


              }, icon: Icon(Icons.photo)),
            ],title: Text('     Alpha-male',)),
        body:ListView(children:[
          Center(child:
          Column(children:[
            SizedBox(height: 30,),
            Container(child: Text('Developers Test Image',style: TextStyle(color: Colors.white,fontSize: 30,)),),

            SizedBox(height: 15,),
            ShowDeveloper(DvevloperImage:'assets/sang.jpg',giho:'γ',rule:'Part: Back-End',classfi:'Class: Gamma'),

            SizedBox(height: 15,),
            ShowDeveloper(DvevloperImage:'assets/han.jpg',giho:'γ',rule: 'Part: Front-End',classfi:'Class: Gamma'),

            SizedBox(height: 15,),
            ShowDeveloper(DvevloperImage:'assets/won.jpg',giho:'δ',rule: 'Part: ML/DL',classfi:'Class: Delta'),

          ]),)],


        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Text('\n"A man needs to be strong." - Alpha male',style:
              TextStyle(fontSize: 20,color: Colors.white,fontFamily: "FrankRuhlLibre-VariableFont_wght"),textAlign: TextAlign.center),
            ))
    );
  }
}

class ShowDeveloper extends StatelessWidget {
  const ShowDeveloper({Key? key, this.DvevloperImage,this.giho,this.rule,this.classfi}) : super(key: key);
  final DvevloperImage;
  final giho;
  final rule;
  final classfi;
  @override
  Widget build(BuildContext context) {
    return Container(height:320,width: 350,padding: EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow:[ BoxShadow(color: Colors.grey,spreadRadius: 3,blurRadius: 7,offset: Offset(2,1))]),
        child:Column(children:[
          Container(height: 250,width: 350,
            child:ClipRRect(borderRadius:BorderRadius.circular(8),child: Image.asset(DvevloperImage,fit: BoxFit.fill,)),),
          SizedBox(height: 10),
          Row(children: [
            SizedBox(width: 23,),
            Container(alignment: Alignment.center,height:40,width: 40,decoration:BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(20)),
                child: Text('$giho',style: TextStyle(fontSize: 34))),
            SizedBox(width: 15,),
            Container(height:55,width: 200,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(height: 20,width:200,color: Colors.transparent,child: Text('$classfi',style: TextStyle(fontSize: 18),),),
                    SizedBox(height: 5,),
                    Container(height: 20,width:200,color: Colors.transparent,child: Text('$rule',style: TextStyle(fontSize: 18)),),
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

  var testurl = 'http://15.164.236.146/api/RegisterUserImg?Model_rst=0';
  var resultData;

  Future PostData() async {
    List<int> imageBytes = widget.UserImagePath.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    Uri url = Uri.parse("http://15.164.236.146/api/RegisterUserImg?Model_rst=0");
    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; sharset=UTF-8',
        }, //this. header is essential to send json data
        body: jsonEncode(
            {
              "first_user": {
                "user_img":base64Image,
                "age": selectedDate,
                "mbti": selectedMBTI
              },
              "result": {
                "human": "False",
                "male_type": "null",
                "dsc": "null",
                "img1": "null",
                "img2": "null",
                "img3": "null",
                "img4": "null"
              }
            }
        )

    );

    var returnbody = utf8.decode(response.bodyBytes);
    var data = jsonDecode(returnbody);
    setState(() {
      resultData = data;
    });
    if(resultData['human'] == 'True'){
      Navigator.push(context, MaterialPageRoute(builder: (c){
        return ResultPage(resultData:resultData,UserImagePath: widget.UserImagePath,);
      }));

    } else
      showDialog(context: context, builder: (context){
        return Dialog(alignment: Alignment.center,backgroundColor: Colors.transparent,
            child: Container(height: 500,
              child: Column(mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Container(width: double.infinity,height: 300,color: Colors.red,child: Image.asset('assets/testm.png',fit: BoxFit.fill,)),
                  Container(width: 500,height: 100,child: Text( '위와 같은 구도로 사진을 선택해 주세요',style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center),),
                  Container(width: 500,height: 100,child: Text( '위와 같은 구도로 사진을 선택해 주세요',style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center),),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("확인",style: TextStyle(fontSize: 30,color: Colors.white))),
                ],
              ),
            ));
      });

    // print(resultData);
    // return utf8.decode(response.bodyBytes);
    print(response.body);
  }

  // http://backendforecs-391845170.ap-northeast-2.elb.amazonaws.com/api/create/first_post/user_tbl?Model_1_rst=1&Model_3_rst=1

  nowTime(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy.MM.dd');
    var strToday = formatter.format(now!);
    return strToday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            actions: [
              TextButton(onPressed: ()async{

                if((selectedMBTI != null)&(selectedDate != null)&(selectedMBTI != MBTI[0])&(widget.UserImagePath != null))
                {
                  await PostData();
                } else
                  showDialog(context: context, builder: (context){
                    return Dialog(backgroundColor: Colors.transparent,child: Container(height: 150,width: 300,child: Column(
                      children: [
                        Text('MBTI와 Brith를\n입력해 주세요',style: TextStyle(color: Colors.white,fontSize: 30,fontFamily:"Roboto-Regular"),textAlign: TextAlign.center),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('확인',style: TextStyle(color: Colors.white,fontSize: 30),))
                      ],
                    )),);
                  });


              }, child: Text('분석',style: TextStyle(color: Colors.white,fontSize: 20),))]),
        body: Center(child: Column(children: [
          Expanded(flex:1,child:Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow: [BoxShadow(color: Colors.grey,spreadRadius: 3,blurRadius: 7,offset: Offset(2,1))]),
            height: 300,width: double.infinity,child:ClipRRect(borderRadius: BorderRadius.circular(8),child: Image.file(widget.UserImagePath,fit: BoxFit.fill)) ,),),
          Expanded(flex:1,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  Container(width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                                child: Text(value,style: TextStyle(fontFamily: "Roboto-Regular"),textAlign: TextAlign.center,));
                          }).toList(), onChanged: (value){setState(() {
                        selectedMBTI=value!;});}),
                    ),
                  ),

                  Container(width: 350,height:50,decoration:
                  BoxDecoration(),
                      child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey[400]),onPressed: (){
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child){
                              return Theme(
                                  data:ThemeData.dark(),
                                  child: child!);
                            }
                        ).then((value){
                          String getToday(){
                            DateTime now = DateTime.now();
                            DateFormat formatter = DateFormat('yyyy-MM-dd');
                            var strToday = formatter.format(value!);
                            return strToday;
                          }
                          selectedDate = getToday();
                        });

                      }, child:Align(alignment: Alignment.centerLeft,child: Text('Brith',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black,fontFamily: "Roboto-Regular")),))),

                  Container(width: 350,height:50 ,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Colors.grey[300]),

                    child: TextField(decoration: InputDecoration(filled:true,fillColor: Colors.grey[300],labelText: '당신의 연봉 단위 만원'),),
                  ),

                ]),),

        ],)),


        bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Text('\n"A man needs to be strong." - Alpha Male',style:
              TextStyle(fontSize: 20,color: Colors.white,fontFamily: "FrankRuhlLibre-VariableFont_wght"),textAlign: TextAlign.center),
            )
        )
    );
  }
}

class ResultPage extends StatelessWidget {
  ResultPage({Key? key,this.resultData,this.UserImagePath}) : super(key: key);
  final UserImagePath;
  final resultData;
  final screencontrolloer = ScreenshotController();



  Future saveAndShare(Uint8List bytes) async{
    final dicectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${dicectory.path}/flutter.png');
    screenImage.writeAsBytesSync(bytes);
    await Share.shareFiles([screenImage.path]);
  }

  Future SaveAlbum(Uint8List bytes)async{
    final dicectory = await getApplicationDocumentsDirectory();
    final screenImage = File('${dicectory.path}/flutter.png');
    screenImage.writeAsBytesSync(bytes);
    var SaveAlbumPath = screenImage.path;

    GallerySaver.saveImage(SaveAlbumPath);
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screencontrolloer,
      child: Scaffold(

          appBar: AppBar(leading: IconButton(onPressed: (){
            Navigator.of(context).popUntil((route) => route.isFirst);

          }, icon: Icon(Icons.home)),
              actions: [

                TextButton(onPressed: ()async{
                  final screenImage = await screencontrolloer.capture();
                  SaveAlbum(screenImage!);
                }, child: Text('저장',style: TextStyle(color:Colors.white,fontSize: 20),)),

                TextButton(onPressed: ()async{
                  final screenImage = await screencontrolloer.capture();
                  saveAndShare(screenImage!);
                }, child: Text('공유',style: TextStyle(color:Colors.white,fontSize: 20),)),

                // TextButton(onPressed: (){}, child: Text('체크',style: TextStyle(color:Colors.white,fontSize: 20),)),
              ]),
          body: ListView(
            children: [
              Center(child: Column(children: [

                Container(decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),borderRadius: BorderRadius.circular(10)),alignment: Alignment.center,width: 300,height: 100,child: Text(resultData['male_type'],style: TextStyle(fontSize: 50,color: Colors.white),)),
                SizedBox(height: 10,),
                Container(decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),borderRadius: BorderRadius.circular(10)),alignment: Alignment.center,width: 400,height: 150,child: Text(resultData['dsc'],style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,)),
                SizedBox(height: 10,),
                Container(width:double.infinity,height: 270,color: Colors.transparent,child:ClipRRect(borderRadius: BorderRadius.all(Radius.circular(20)),child: Image.file(UserImagePath,fit: BoxFit.fill))),
                SizedBox(height: 10,),

                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

                  Container(height: 200,width: 200,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.memory(base64Decode(resultData['img1']),fit: BoxFit.fill,)),),
                  Container(height: 200,width: 200,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.memory(base64Decode(resultData['img2']),fit: BoxFit.fill,)),),
                ]),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  Container(height: 200,width: 200,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.memory(base64Decode(resultData['img3']),fit: BoxFit.fill,)),),
                  Container(height: 200,width: 200,child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.memory(base64Decode(resultData['img4']),fit: BoxFit.fill,)),),
                ]),
              ]),)
            ],
          )
      ),
    );
  }
}