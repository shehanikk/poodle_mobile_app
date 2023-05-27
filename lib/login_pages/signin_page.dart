import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/login_pages/login_page.dart';
import 'package:poodle_mobie_application/main_pages/navigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


  void saveUsernameToFirebase() {
    String username = _userNameTextController.text;
    String email = _emailTextController.text;

    FirebaseFirestore.instance
        .collection('userDog')
        .doc(email)
        .set({'username': username, 'emial': email})
        .then((_) {
      print('Username saved to Firebase: $username');
    })
        .catchError((error) {
      print('Failed to save username to Firebase: $error');
    });
  }



  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color(0xFF072972),
      body: Column(
        children: [
          Container(
            width: w*100,
            height: h*0.34,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/sign_in.png"
                    ),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: Offset(1,1),
                            color: Colors.grey.withOpacity(0.4)
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _userNameTextController,
                    decoration: InputDecoration(
                      hintText: "Username",
                        prefixIcon: Icon(Icons.person, color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: Offset(1,1),
                            color: Colors.grey.withOpacity(0.4)
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                        hintText: "Email address",
                        prefixIcon: Icon(Icons.email, color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: Offset(1,1),
                            color: Colors.grey.withOpacity(0.4)
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _passwordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password, color: Colors.black,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                SizedBox(height: 38,),

                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                          password: _passwordTextController.text).then((value){
                        print("created new account");
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Mynavigationbar()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                      saveUsernameToFirebase();
                    },

                    child: const Text('CREATE ACCOUNT'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all(const Size(345.9, 60.1)),
                      backgroundColor: MaterialStateProperty.all(Color(0xFF64C251)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontSize: 17,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60,),
                RichText(text: TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: " Login",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF64C251),
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                    recognizer: TapGestureRecognizer()..onTap=() {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                }
                      ),
                    ]
                )
                )

              ],
            ),
          )
        ],
      ),

    );
  }
}


