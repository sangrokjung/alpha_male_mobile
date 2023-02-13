import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './campage.dart';


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
  List<String> imagePaths =[];
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

//여기부터 메인 홈페이지 시작
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color:Colors.black38,width: double.infinity,height: double.infinity,
        child: Column(
          children:[
            SizedBox(height: 100,),
            //메인 로고,이름
            Container(
                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(50)),
                child:Column(
                  children:[Text('alpha\nfinder',style:TextStyle(fontSize:100),textAlign:TextAlign.center)])),


            //설명란?
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            width: 300,
            decoration: BoxDecoration( color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
              child:Text("사용법\nAge 와 MBTI를 입력후\n다음 버튼을 눌러주세요",style:TextStyle(fontSize: 25),textAlign: TextAlign.center
                ,),alignment: Alignment.center),
            //날짜 버튼

           Container(color: Colors.deepPurple.shade50,
               child:MaterialButton(onPressed:_showDatePicker,
                   child: Padding(padding: EdgeInsets.all(20.0),
                       child: Text("Your Age",style:TextStyle(color:Colors.black,fontSize: 25))))),

            //mbti 버튼

            Container(color: Colors.green,width: 170,
                child:Column(mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Your MBTI",style:TextStyle(color: Colors.black,fontSize: 25)),
                      DropdownButton(style:TextStyle(fontSize: 25,color: Colors.black,),
                          value: selectedMBTI, items: MBTI.map((value)
                          {return DropdownMenuItem(
                            value:value,
                            child: Text(value));
                          }).toList(),onChanged: (value){setState(() {selectedMBTI = value!;});})]))
              ,

            //확인,다음 버튼, 카메라 앨범으로

            Container(
              color: Colors.brown,width: 170,
              child:MaterialButton(onPressed:(){
                if((selectedMBTI!=null) & (selectedDate != null) & (selectedMBTI != MBTI[0])){
                  // 테스트 끝나면 지울껏들
                  print("정상");
                  print(selectedMBTI);
                  print(selectedDate);
                  //끝

                  Navigator.push(context,
                      MaterialPageRoute(builder:(c){
                        return CamPage(selectedMBTI:selectedMBTI,selectedDate:selectedDate);}));

                }else //입력 안한경우 팝업창
                  showDialog(context: context, builder: (context){
                    return Dialog(child:Text('반드시 당신의 MBTI와 생년월일을 선택해주세요'));
                  });
              },
                  child:Padding(padding: EdgeInsets.all(20.0),
                    child: Text("시작하기",style: TextStyle(fontSize: 25)),)),
            ),],),
      ),);}}
