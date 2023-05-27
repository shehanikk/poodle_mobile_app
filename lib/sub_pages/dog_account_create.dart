import 'dart:io';

import 'package:date_picker_timeline/extra/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class DogCreate extends StatefulWidget {
  const DogCreate({Key? key}) : super(key: key);

  @override
  State<DogCreate> createState() => _DogCreateState();
}

class _DogCreateState extends State<DogCreate> {

  XFile? imageFile;

  String? email;

  String? getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return user.email;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    email = getUserEmail();
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController dogNameController = TextEditingController();
  TextEditingController dogBirthDayController = TextEditingController();
  TextEditingController dogBreedController = TextEditingController();
  TextEditingController dogSexController = TextEditingController();

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = selectedImage;
    });
  }

  Future<String> uploadImage(XFile imageFile) async {
    try {
      // Access Firebase Storage instance
      final storage = firebase_storage.FirebaseStorage.instance;

      // Create a unique filename for the image
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

      // Upload the image to Firebase Storage
      final task = await storage.ref().child(fileName).putFile(File(imageFile.path));

      // Get the download URL of the uploaded image
      final imageUrl = await task.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      // Handle any errors that occur during image upload
      print('Error uploading image: $e');
      throw e;
    }
  }

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

      if (imageFile != null) {
        final String imageUrl = await uploadImage(imageFile!);
        dogDetails['imageUrl'] = imageUrl;
      }

      final dogRef = await firestore.collection('userDog').doc(email).collection('dog').doc(dogNameController.text).set(dogDetails);

      // Retrieve the document ID of the newly created dog
      // final dogId = dogRef.id;

      // Update the dog document with the image URL
      if (imageFile != null) {
        await firestore.collection('userDog').doc(email).collection('dog').doc(dogNameController.text).update({
          'imageUrl': dogDetails['imageUrl'],
        });
      }


      // Add dog details to Firestore
     // await firestore.collection('userDog').doc(uid).collection('dog').add(dogDetails);

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
                      //child: Center(child: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,),),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                        onPressed: _selectImage,
                      ),
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
                  TextFieldWidget('Email',Icons.email_rounded,emailController),
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
