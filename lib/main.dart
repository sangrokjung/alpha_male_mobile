
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
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
}class _MyAppState extends State<MyApp> {


  var UserImagePath;

  final urlImages= [
    'https://t1.daumcdn.net/news/202210/04/kukinews/20221004152604048swko.jpg',
    'https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202301/15/mydaily/20230115054859216prji.jpg',
  ];

//여기부터 메인 홈페이지 시작
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('alpha finder'),
          actions:[
            IconButton(onPressed: ()async{

              var picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.camera);
              //TO convert Xfile into file

              File file = File(image!.path);
              UserImagePath = file;
              print(UserImagePath);

              if(UserImagePath != null){
                Navigator.push(context,
                    MaterialPageRoute(builder:(c){
                      return SelectPage();}));
              } else
                showDialog(context: context, builder: (context){
                  return Dialog(child:Text('다시 사진 촬영 또는 사진을 선택해주세요',textAlign:TextAlign.center,style: TextStyle(fontSize: 30),));
                });

              
            }, icon:const Icon(Icons.camera_alt_outlined)),

            IconButton(onPressed: ()async{
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null){
                UserImagePath = File(image.path);
                print(UserImagePath);
              }
              if(UserImagePath != null){

                Navigator.push(context,
                    MaterialPageRoute(builder:(c){
                      return SelectPage(UserImagePath:UserImagePath);}));

              } else
                showDialog(context: context, builder: (context){
                  return Dialog(child:Text('다시 사진 촬영 또는 사진을 선택해주세요',textAlign:TextAlign.center,style: TextStyle(fontSize: 30),));
                });
            }, icon:const Icon(Icons.photo_album_outlined))]),
      body: Center(
        child:CarouselSlider(
          options: CarouselOptions(height: 500.0),
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
      ),
    );
  }
}



class SelectPage extends StatefulWidget {
  SelectPage({Key? key,this.UserImagePath}) : super(key: key);
  var UserImagePath;
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



  void _showCupertinoPicker(BuildContext context)async{
    final List<int> _items = List.generate(10, (index) => index);
    int result = _items[0];

    await showCupertinoModalPopup(
        context: context,
        builder:(context) => Container(
          height: 200.0,
          child: CupertinoPicker(
              itemExtent: 50.0,
              onSelectedItemChanged: (int index){
                result = _items[index];
              },
              children: _items.map((e) => Text('no.$e')).toList()),
        ),);
       print(result);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Age & MBTI'),
        centerTitle:true ,
          leading:IconButton(onPressed: (){

            Navigator.pop(context);


          }, icon: Icon(Icons.chevron_left_outlined)),
          actions: [IconButton(onPressed: (){}, icon:Icon(Icons.chevron_right_outlined))]),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children:
        [
          Container(color: Colors.red,
            child: MaterialButton(onPressed:(){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
              ).then((value){
                String getToday(){
                  DateTime now = DateTime.now();
                  DateFormat formatter = DateFormat('yyyy.MM.dd');
                  var strToday = formatter.format(value!);
                  return strToday;
                }
                selectedDate = getToday();
              });
            }, child: Text('age',style: TextStyle(fontSize: 30),)),
          ),

          SizedBox(height: 100,),


          Container(color: Colors.blue,
            child: DropdownButton(style:TextStyle(fontSize: 25,color: Colors.black,),
                value: selectedMBTI, items: MBTI.map((value)
                {return DropdownMenuItem(
                    value:value,
                    child: Text(value));
                }).toList(),onChanged: (value){setState(() {selectedMBTI = value!;});}),
          ),

          SizedBox(height: 100,),
          MaterialButton(onPressed: (){
            print(selectedDate);
            print(selectedMBTI);



          },child: Text('check'),),

          CupertinoButton(
              child: Text('쿠퍼pic'),
              onPressed: (){
                _showCupertinoPicker(context);
              })
        ]),
      ),
    );
  }
}
