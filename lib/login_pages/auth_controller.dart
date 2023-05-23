import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:poodle_mobie_application/login_pages/login_page.dart';
import 'package:poodle_mobie_application/main_pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(()=>Login());
    }else{
      Get.offAll(()=>HomePage());
    }
  }

  void register (String email, password)async{
    try{
      await auth.createUserWithEmailAndPassword( email: email, password: password);

    }catch(e){
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Account creation failed",
            style: TextStyle(
          color: Colors.white
      ),
      ),
    messageText: Text(
    e.toString(),
    style: TextStyle(
    color: Colors.white
    ),
    ),
      );

    }
  }
}