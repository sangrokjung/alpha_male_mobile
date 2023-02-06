// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
//
//
//
// //카메라 앨범 스테이트 페이지
//
// class CamPage extends StatefulWidget {
//   const CamPage({Key? key,}) : super(key: key);
//   @override
//   State<CamPage> createState() => _CamPageState();
// }
// class _CamPageState extends State<CamPage> {
//   var userImage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         Column(
//           children: [
//             Expanded(//카메라 버튼
//                 child:Container(color: Colors.brown,width: double.infinity,
//                   child: MaterialButton(onPressed: ()async{
//                     var picker = ImagePicker();
//                     var image = await picker.pickImage(source: ImageSource.camera);
//                     if (image != null){
//                       setState(() {
//                         userImage = File(image.path);
//                       });
//                     }
//                   },
//                     child: Text('Camera',style:TextStyle(fontSize: 40)),),
//                 ),flex: 6),
//
//
//             Expanded(//갤러리 버튼
//                 child: Container(color: Colors.yellow,width:double.infinity,
//                     child:MaterialButton(onPressed:()async{
//                       var picker = ImagePicker();
//                       var image = await picker.pickImage(source: ImageSource.gallery);
//                       if(image != null){
//                         setState(() {
//                           userImage = File(image.path);
//                         });
//                       }
//                       Image.file(userImage);
//
//
//                     },
//                       child: Text('Gallery',style:TextStyle(fontSize: 40)),)),flex: 5),
//
//
//             Expanded(// 뭐할지 고민
//                 child: Container(color: Colors.green,width: double.infinity,
//                   child: MaterialButton(onPressed: (){},
//                       child: Text('뭐할까?',style: TextStyle(fontSize: 40),)),),flex: 2),
//           ],
//         )
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // class Upload extends StatelessWidget {
// //   const Upload({Key? key,this.userImage}) : super(key: key);
// //   final userImage ;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Column(
// //         crossAxisAlignment:CrossAxisAlignment.start,
// //         children: [
// //           Image.file(userImage),
// //           Text("업로드 화면")
// //         ],
// //
// //
// //       ),
// //     );
// //   }
// // }