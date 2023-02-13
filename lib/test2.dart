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
      body: Column(
        children: [
          //메인 로고,이름
          Expanded(
            child: Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(alignment: Alignment.center,
                  child: Text('alpha\nfinder',style:TextStyle(fontSize: 100),)),
              color: Colors.red,
            ),
            flex: 5,
          ),
          //설명란?
          Expanded(child: Container(color: Colors.yellow,
              child: Text("Age 와 MBTI를 입력후\n다음 버튼을 눌러주세요",style:TextStyle(fontSize: 20),), alignment: Alignment.center),
              flex: 1),

          //날짜 버튼
          Expanded(child:Container(
              color: Colors.deepPurple.shade50, width: double.infinity,
              child:MaterialButton(onPressed:_showDatePicker,
                  child: Padding(padding: EdgeInsets.all(20.0),
                      child: Text("Your Age",
                          style:TextStyle(color: Colors.black,fontSize: 25)
                      )
                  )
              )
          ),
              flex: 1),
          //mbti 버튼
          Expanded(child: Column(
            children: [
              Container(color: Colors.green,width: double.infinity,height: 140,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your MBTI",
                        style:TextStyle(color: Colors.black,fontSize: 20)),
                    DropdownButton(
                      style: TextStyle(fontSize: 25,color: Colors.black,),
                      value: selectedMBTI,
                      items: MBTI.map(
                              (value){
                            return DropdownMenuItem(
                              value:value,
                              child: Text(value),
                            );
                          }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedMBTI = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),flex: 2),

          //확인,다음 버튼, 카메라 앨범으로
          Expanded(child:Container(
            color: Colors.brown,width: double.infinity,
            child:MaterialButton(onPressed:(){
              print(context);
              if((selectedMBTI!=null) & (selectedDate != null) & (selectedMBTI != MBTI[0])){
                print("정상");
                print(selectedMBTI);
                print(selectedDate);
                Navigator.push(context,
                    MaterialPageRoute(builder:(c){return
                      CamPage(selectedMBTI:selectedMBTI,selectedDate:selectedDate); // 캠 페이지로 이동
                    }));

              }else //입력 안한경우 팝업창
                showDialog(context: context, builder: (context){
                  return Dialog(child:Text('반드시 당신의 MBTI와 생년월일을 선택해주세요'));
                });
            },
                child:Padding(padding: EdgeInsets.all(20.0),
                  child: Text("다음",style: TextStyle(fontSize: 25)),)),

            // color: Colors.green,
          ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}









// //업로드 페이지
// class UploadPage extends StatelessWidget {
//   UploadPage({Key? key,this.userImage,required this.userImagePath,this.selectedMBTI}) : super(key: key);
//   final userImage;
//   final selectedMBTI;
//   List<String> userImagePath = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
//         children: [Image.file(userImage),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               TextButton(onPressed: (){
//                 print(selectedMBTI);
//                 Navigator.pop(context);
//               },child: Text('뒤로가기')),
//               TextButton(onPressed: (){
//                 server.postReq(userImage:userImage,selectedMBTI:selectedMBTI);
//                 // mbti age image 전송(post) 해야함
//                 // 그리고 보낸 사진이 서버에서 처리 되어서 돌아오면 결과창을 띄어야함
//                 // 이 것들이 아니라면 로딩 아이콘을 띄워야함
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (c){return ResultPage(userImage:userImage,userImagePath:userImagePath);}));
//
//
//               },child: Text('이미지 업로드')),
//             ],
//           ),
//         ],
//       ),
//
//
//     );
//   }
// }



// class ResultPage extends StatelessWidget {
//   ResultPage({Key? key,this.userImage,required this.userImagePath,this.selectedMBTI}) : super(key: key);
//   final userImage;
//   final selectedMBTI;
//   List<String> userImagePath = [];
//   String text = "";
//   String subject = "";
//   final controller = ScreenshotController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Screenshot(
//       controller: controller,
//       child: Scaffold(
//           body:Container(height:double.infinity,width: double.infinity,color: Colors.green,
//             child: Column(
//               children: [
//                 Container(color: Colors.yellow,width: 300,height: 300,alignment: Alignment.bottomCenter,margin: EdgeInsets.all(70.0)),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
//                   Container(color: Colors.deepPurple,height: 100,width: 100,),
//                   Container(color: Colors.deepPurple,height: 100,width: 100,),
//                 ]),
//                 SizedBox(height: 40,),
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
//                   Container(color: Colors.blue,height: 100,width: 100,),
//                   Container(color: Colors.blue,height: 100,width: 100,),
//                 ],),
//                 SizedBox(height: 20,),
//                 Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//                   Container(width: 100,height: 100,color: Colors.amber,
//                       child: TextButton(onPressed: ()async{
//                         final screenImage = await controller.capture();
//
//                         saveAndShare(screenImage!);
//                       },child: Text(''))
//                   )
//                 ],)
//               ],
//             ),
//
//           )
//       ),
//     );
//
//   }
//   Future saveAndShare(Uint8List bytes) async{
//     final dicectory = await getApplicationDocumentsDirectory();
//     final screenImage = File('${dicectory.path}/flutter.png');
//     screenImage.writeAsBytesSync(bytes);
//     await Share.shareFiles([screenImage.path]);
//   }
// }






// 값 잘 들어왔는지 확인
// print("확인");
// print(selectedMBTI);
// print(selectedDate);










//------------------------------------------------------------------



// const _API_PREFIX = 'https://jsonplaceholder.typicode.com/posts';
// class Server {
//   const Server({Key? key,this.userImage,this.selectedMBTI,this.selectedDate});
//   final userImage;
//   final selectedMBTI;
//   final selectedDate;
//
//
//   Future<void> getReq() async {
//     Response response;
//     Dio dio = new Dio();
//     response = await dio.get("$_API_PREFIX");
//
//
//     print(response.data[0].toString());
//     print(response.data[0]['image'].toString());
//
//
//
//   }
//   Future<void> postReq({required userImage, required selectedMBTI, required selectedDate}) async{
//     Response response;
//     Dio dio = new Dio();
//     response = await dio
//         .post(_API_PREFIX,data:{
//           "userimage":'$userImage',
//       "usermbti":"$selectedMBTI",
//       "userage":"$selectedDate",
//
//     });
//     print(response.data.toString());
//
//   }
// }
//
//
// Server server = Server();


