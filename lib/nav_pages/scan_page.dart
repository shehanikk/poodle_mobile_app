import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class Scane extends StatefulWidget {
  const Scane({Key? key}) : super(key: key);

  @override
  State<Scane> createState() => _ScaneState();
}

class _ScaneState extends State<Scane> {
  final picker = ImagePicker();
  var image;
  File? _image;



  callAPICamera() async {

    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    //final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image ==  null)  return;

    final imageTemp = File(image.path);

    setState(() => _image=imageTemp);

    var url = Uri.parse('http://192.168.43.15:8080/recognize_breed');
    var request = http.MultipartRequest('POST', url);
    if (_image != null) {
      var bytes = await _image!.readAsBytes();
      final imageFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        contentType: MediaType.parse("image/jpeg"),
        filename: "image.jpg",
      );
      request.files.add(imageFile);
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var resJson = convert.jsonDecode(responseBody);
      print(resJson.toString());
    }
  }

  callAPIGallery() async {

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image ==  null)  return;

    final imageTemp = File(image.path);

    setState(() => _image=imageTemp);

    var url = Uri.parse('http://192.168.43.15:8080/recognize_breed');
    var request = http.MultipartRequest('POST', url);
    if (_image != null) {
      var bytes = await _image!.readAsBytes();
      final imageFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        contentType: MediaType.parse("image/jpeg"),
        filename: "image.jpg",
      );
      request.files.add(imageFile);
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var resJson = convert.jsonDecode(responseBody);
      print(resJson.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF072972),

        body: Column(
          children: [
            // _image == null ? Image.asset("assets/ai_topim.png") :
            // Positioned(
            //
            //   child: (
            //       Image.file(_image!,height: 200,width: 200,fit: BoxFit.cover,)
            //   ),
            // ),
            // Positioned(
            // height: size.height*0.4,
            //               width: size.width,
            //
            //   child: Container(
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //           image: AssetImage("assets/ai_topim.png"),
            //
            //         )
            //     ),
            //   ),
            // ),
            //
            // Positioned(
            //   top: size.height*0.35,
            //   height: size.height*0.65,
            //   width: size.width,
            //
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(36.0),
            //           topRight: Radius.circular(36.0),
            //         )
            //     ),
            //     child: Column(
            //       children: [
            //         SizedBox(height: 80,),
            //         Text("Prediction", style:
            //         TextStyle(
            //           fontSize: 40,
            //           fontWeight: FontWeight.bold,
            //         ),),
            //         SizedBox(height: 10,),
            //         Text(
            //          "Shitzu",
            //           style: TextStyle(
            //             fontSize: 20,
            //             color: Colors.green,
            //             fontWeight: FontWeight.bold,
            //           ),),
            //         SizedBox(height: 90,),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             OutlinedButton(onPressed: () async {
            //              await callAPICamera();
            //             }, child: null, ),
            //
            //             SizedBox(width: 60,),
            //             OutlinedButton(onPressed: () async{
            //               await callAPIGallery();
            //
            //             }, child: null,),
            //           ],
            //
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            _image == null ? Image.asset("assets/ai_topim.png") :
            ClipRRect(

              child: (

                  Image.file(_image!,height: 200,width: 200,fit: BoxFit.cover,)
              ),
            ),
            Container(
              child: Row(
                children: [
                  OutlinedButton(onPressed: () async {
                    await callAPICamera();
                  }, child: null),
                  OutlinedButton(onPressed: () async {
                    await callAPICamera();
                  }, child: null),
                ],
              ),
            )
          ]

        ),
    );
  }
}



