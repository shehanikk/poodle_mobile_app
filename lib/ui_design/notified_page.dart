import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back,
          color: Colors.white,
          ),
        ),
        title: Text(this.label.toString().split("|")[0], style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF64C251)
          ),
          child: Center(
            child: Text(this.label.toString().split("|")[1], style: TextStyle(
                color: Colors.black,
              fontSize: 22,

            ),),
          ),
        ),
      ),

    );
  }
}
