import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import './uploadpage.dart';

class CamPage extends StatelessWidget {
  CamPage({Key? key,this.selectedMBTI, this.selectedDate}) : super(key: key);
  var selectedMBTI;
  var selectedDate;
  var userImage;
  List<String> userImagePath =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:
          Column(
            children: [
              Expanded(//카메라 버튼
                  child:Container(color: Colors.brown,width: double.infinity,
                    child: MaterialButton(onPressed: ()async{
                      var picker = ImagePicker();
                      var image = await picker.pickImage(source: ImageSource.camera);
                      if (image != null){
                          userImage = File(image.path);
                          userImagePath.add(userImage.path);
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder:(c){
                            return UploadPage(userImage:userImage,selectedDate:selectedDate,selectedMBTI:selectedMBTI);
                          }));
                      },
                      child: Text('Camera',style:TextStyle(fontSize: 40)),),
                  ),flex: 6),


              Expanded(//갤러리 버튼
                  child: Container(color: Colors.yellow,width:double.infinity,
                      child:MaterialButton(onPressed:()async{
                        var picker = ImagePicker();
                        var image = await picker.pickImage(source: ImageSource.gallery);
                        if(image != null){
                          userImage = File(image.path);
                          userImagePath.add(userImage.path);
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder:(c){
                              return UploadPage(userImage:userImage,selectedDate:selectedDate,selectedMBTI:selectedMBTI);
                            }));
                        },
                        child: Text('Gallery',style:TextStyle(fontSize: 40)),)),flex: 5),


              Expanded(// 뭐할지 고민
                  child: Container(color: Colors.green,width: double.infinity,
                    child: MaterialButton(onPressed: (){
                      print(selectedMBTI);
                      print(selectedDate);

                    },
                        child: Text('뭐할까 뒤로가기?',style: TextStyle(fontSize: 40),)),),flex: 2),
            ],
          )
      );
  }
}


//
// class CamPage extends StatefulWidget {
//   CamPage({Key? key, required  selectedMBTI, required selectedDate}) : super(key: key);
//
//
//   @override
//   State<CamPage> createState() => _CamPageState();
// }
// class _CamPageState extends State<CamPage> {
//   _CamPageState({Key? key});
//   var selectedMBTI;
//   var selectedDate;
//
//   var userImage;
//   List<String> userImagePath =[];
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
//                         userImagePath.add(userImage.path);
//
//                       });
//                     }
//                     Navigator.push(context,
//                         MaterialPageRoute(builder:(c){return UploadPage(userImage: userImage,userImagePath:userImagePath);
//                         }));
//
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
//                           userImagePath.add(userImage.path);
//
//
//                         });
//                       }
//                       Navigator.push(context,
//                           MaterialPageRoute(builder:(c){var selectedMBTI;
//                           return UploadPage(userImage: userImage,userImagePath:userImagePath,selectedMBTI:selectedMBTI);
//                           }));
//
//
//                     },
//                       child: Text('Gallery',style:TextStyle(fontSize: 40)),)),flex: 5),
//
//
//             Expanded(// 뭐할지 고민
//                 child: Container(color: Colors.green,width: double.infinity,
//                   child: MaterialButton(onPressed: (){
//                     print(selectedMBTI);
//                     print(selectedDate);
//
//                   },
//                       child: Text('뭐할까 뒤로가기?',style: TextStyle(fontSize: 40),)),),flex: 2),
//           ],
//         )
//     );
//   }
// }