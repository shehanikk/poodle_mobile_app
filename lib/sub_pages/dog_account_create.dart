import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DogCreate extends StatefulWidget {
  const DogCreate({Key? key}) : super(key: key);

  @override
  State<DogCreate> createState() => _DogCreateState();
}

class _DogCreateState extends State<DogCreate> {

  TextEditingController emailController = TextEditingController();
  TextEditingController dogNameController = TextEditingController();
  TextEditingController dogBirthDayController = TextEditingController();
  TextEditingController dogBreedController = TextEditingController();
  TextEditingController dogSexController = TextEditingController();

  Future<void> createDogAccount() async {
    final dogDetails = {
      'email': emailController.text,
      'dogName': dogNameController.text,
      'dogBirthDay': dogBirthDayController.text,
      'dogBreed': dogBreedController.text,
      'dogSex': dogSexController.text,
    };

    try {
      // Access Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Add dog details to Firestore
      await firestore.collection('dogs').add(dogDetails);

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Dog details added to Firestore'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      ).then((_) {
        // Clear text fields after successful submission
        emailController.clear();
        dogNameController.clear();
        dogBirthDayController.clear();
        dogBreedController.clear();
        dogSexController.clear();
      });
    } catch (e) {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add dog details to Firestore'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('Create Pet Account'),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height*0.2,

              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffD6D6D6)
                      ),
                      child: Center(child: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,),),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  TextFieldWidget('Email Address',Icons.email_rounded,emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget('Dog Name',Icons.mood_rounded,dogNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget('Dog Birthday',Icons.date_range_rounded,dogBirthDayController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget('Breed Type',Icons.pets_rounded,dogBreedController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget('Dog Sex',Icons.pets_rounded,dogSexController),
                  const SizedBox(
                    height: 30,
                  ),
                  greenButton('Create',(){}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFieldWidget(String title,IconData iconData,TextEditingController controller){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black87),),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1
              )
            ],
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextField(
            controller: controller,
            cursorHeight: 30,
            cursorColor: Colors.blue,
            cursorWidth: 2,
            cursorRadius:const Radius.circular(500),
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)),
            decoration: InputDecoration(
                border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Icon(iconData,color: Colors.green,),
              )

            ),
          ),
        )
      ],
    );
  }

  Widget greenButton(String title, Function onPressed) {
    return MaterialButton(
      minWidth: Get.width,
      height: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      color: Colors.green,
      onPressed: () => createDogAccount(),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
