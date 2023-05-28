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
  dynamic _output;



  callAPICamera() async {

    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    //final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image ==  null)  return;

    //setting image to image file path
    final imageTemp = File(image.path);

    setState(() => _image=imageTemp);

    var url = Uri.parse('http://10.5.6.18:8080/recognize_breed');
    //request equale to post method and url
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

      setState(() {
        _output = resJson;
      });
    }
  }

  callAPIGallery() async {

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image ==  null)  return;

    final imageTemp = File(image.path);

    setState(() => _image=imageTemp);

    var url = Uri.parse('http://10.5.6.18:8080/recognize_breed');
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

      setState(() {
        _output = resJson;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('SCAN YOUR DOG'),
      ),

      body: Center(
        child: Column(

          children: [
            _image == null
                ? Image.asset('assets/ai_topui.png') :
            ClipRRect(
              child: (
                  Image.file(_image!,height: 400,width: 400, fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: Text(
                _output.toString(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
              ),
            ),

            SizedBox(height: 90,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                Container(
                  child: Material(
                    color: Colors.white,
                    elevation: 0,
                    borderRadius: BorderRadius.circular(50),

                    child: InkWell(
                      splashColor: Colors.black26,
                      onTap: ()  async {
                        await callAPICamera();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Ink.image(
                            image: const AssetImage(
                                "assets/camera_button.png"
                            ),
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Material(
                    color: Colors.white,
                    elevation: 0,
                    borderRadius: BorderRadius.circular(50),

                    child: InkWell(
                      splashColor: Colors.black26,
                      onTap: () async {
                        await callAPIGallery();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Ink.image(
                            image: const AssetImage(
                                "assets/gallery_button.png"
                            ),
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),

    );
  }
}




