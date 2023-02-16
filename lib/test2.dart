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
    });

  }




  final urlImages= [
    'https://t1.daumcdn.net/news/202210/04/kukinews/20221004152604048swko.jpg',
    'https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202301/15/mydaily/20230115054859216prji.jpg',

  ];




  nowTime(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy.MM.dd');
    var strToday = formatter.format(now!);
    return strToday;
  }





  Future PostImage() async {

    List<int> imageBytes = UserImagePath.readAsBytesSync();
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
    print(imageBytes);
    print(response.body);
    print(response.statusCode);
    // print(response.body);
  }


  // 'http://10.0.0.103:5000/profile/upload-mutiple'
  // 'https://jsonplaceholder.typicode.com/posts'
  // 'https://jsonplaceholder.typicode.com/albums'


  Future uploadPhotos() async {
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    if(UserImagePath != null){

      request.fields['mbti'] = selectedMBTI;
      request.fields['age'] = selectedDate;

      // request.files.add(await http.MultipartFile.fromPath('image', UserImagePath.path));

    }

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);

    print(response.statusCode);

    print(responseString);

    return responseString;
  }










  Future test()async {
    http.MultipartRequest request = await http.MultipartRequest('POST', Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    request.fields['mbti'] = selectedMBTI;


    request.files.add(await http.MultipartFile.fromPath('파일 이름', UserImagePath.path));
    var respone = await request.send();
    print(respone.statusCode);
    print(respone);



  }










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




            }, icon:const Icon(Icons.camera_alt_outlined)),

            IconButton(onPressed: ()async{
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null){
                UserImagePath = File(image.path);
                userImagePaths.add(UserImagePath.path);
                print(UserImagePath);
              }
            }, icon:const Icon(Icons.photo_album_outlined))]),





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
              child:Column(
                children: [


                  MaterialButton(onPressed:()async{


                    if((selectedMBTI!=null) & (selectedDate != null) & (selectedMBTI != MBTI[0]) &(UserImagePath != null) ){


                      // await PostImage();


                      // var request = new http.MultipartRequest('POST', Uri.parse('https://jsonplaceholder.typicode.com/posts'));
                      // request.fields['age'] = '$selectedDate';
                      // request.fields['mbti'] = '$selectedMBTI';
                      //
                      // request.files.add(await http.MultipartFile.fromPath('userImage.png',UserImagePath));
                      //
                      //
                      //
                      //
                      // var res = await request.send();
                      // print(res.statusCode);





                      // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
                      // //요청에 이미지 파일 추가
                      // final response = await http.post(url,
                      //     headers: <String, String>{
                      //   'Content-Type':'application/json; charset=UTF-8',
                      //     },
                      //     body: jsonEncode({"userImage":'$UserImagePath',"mbti":'$selectedMBTI','age':'$selectedDate'}));
                      // print('Response status: ${response.statusCode}');
                      // print('Response body: ${response.body}');


                      await getDate();

                      Navigator.push(context,
                          MaterialPageRoute(builder:(c){
                            return ResultPage(resultImage:resultImage);}));


                    }else //입력 안한경우 팝업창
                      showDialog(context: context, builder: (context){
                        return Dialog(child:Text('반드시 당신의 MBTI,생년월일,사진을 선택해주세요',textAlign:TextAlign.center,style: TextStyle(fontSize: 30),));
                      });


                  },
                      child:Padding(padding: EdgeInsets.all(20.0),
                        child: Text("시작하기",style: TextStyle(fontSize: 25)),)),
                ],
              ),
            ),
            Container(child: TextButton(onPressed: ()async{
              // test();
              // uploadPhotos();
              // print(UserImagePath.path);

              PostImage();

              // String imgpath = UserImagePath.path;
              // File imgfile = File(imgpath);
              // Uint8List imgbytes = await UserImagePath.readAsBytesSync();
              // String bs4str = base64.encode(imgbytes);
              // print(bs4str);


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


