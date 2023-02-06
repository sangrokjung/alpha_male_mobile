// import 'dart:io';
// import 'camerapage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart'as http ;
//
//
// void main(){
//   runApp(
//       MaterialApp(
//           theme: ThemeData(
//             appBarTheme: AppBarTheme(color:Colors.white10,elevation:0.0),
//           ),
//           home:MainHome()
//       )
//   );
// }
//
//
// class MainHome extends StatefulWidget {
//   const MainHome({Key? key}) : super(key: key);
//
//   @override
//   State<MainHome> createState() => _MyAppState();
// }
//
//
// class _MyAppState extends State<MainHome> {
//   var userImage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Title(
//             color: Colors.black,child:Text(
//           "Alpha",style: TextStyle(
//             fontFamily:'BebasNeueRegular',fontSize: 100),
//         )),
//           Container(
//             child: Column(mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(child: TextField(),width: 200),
//                 SizedBox(child: TextField(),width: 200)],
//
//           ),),
//
//           Row(mainAxisAlignment: MainAxisAlignment.center,
//                   children:[
//                     TextButton(onPressed: (){
//                       Navigator.push(context,MaterialPageRoute(
//                           builder: (c)=>SelectPage())
//                       );
//                     }, child: Text('전체 확인후 넘김')),
//
//
//                   ])
//               ]
//             ),
//           );
//   }
// }
//
//
//
//
//
//
// class SelectPage extends StatefulWidget {
//   const SelectPage({Key? key}) : super(key: key);
//
//   @override
//   State<SelectPage> createState() => _SelectPageState();
// }
//
// class _SelectPageState extends State<SelectPage> {
//   var userImage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//
//           TextButton(onPressed: ()async{
//             var picker = ImagePicker();
//             var image = await picker.pickImage(source: ImageSource.camera);
//
//             if(image != null) {
//               setState(() {
//                 userImage = File(image.path);
//               });
//             }
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (c)=>Upload(userImage:userImage))
//             );
//
//           }, child: Text("camera")),
//           TextButton(onPressed: ()async{
//             var picker = ImagePicker();
//             var image = await picker.pickImage(source: ImageSource.gallery);
//
//             if(image != null) {
//               setState(() {
//                 userImage = File(image.path);
//               });
//             }
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (c)=>Upload(userImage:userImage))
//             );
//
//           }, child: Text("gallery")),
//
//         ],
//       ),
//     );
//   }
// }
//
// class Upload extends StatelessWidget {
//   const Upload({Key? key,this.userImage}) : super(key: key);
//   final userImage ;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment:CrossAxisAlignment.start,
//         children: [
//
//           Image.file(userImage),
//           TextButton(onPressed: (){
//
//           //  업로드버튼 누르면 서버로 넘김
//             //그리고 결과창 으로 넘김
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (c)=>ResultPage())
//             );
//
//           }, child: Text("업로드"))
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
// class ResultPage extends StatefulWidget {
//   const ResultPage({Key? key}) : super(key: key);
//
//   @override
//   State<ResultPage> createState() => _ResultPageState();
// }
//
// class _ResultPageState extends State<ResultPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Text('결과창'),
//     );
//   }
// }