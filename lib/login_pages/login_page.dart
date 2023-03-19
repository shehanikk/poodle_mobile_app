import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/login_pages/signin_page.dart';
import 'package:poodle_mobie_application/main_pages/navigationbar.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w*150,
            height: h*0.55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/login_page.png"
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(height: 20,),
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
                SizedBox(height: 25,),
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
                SizedBox(height: 25,),
                Row(
                  children: [
                    Expanded(child: Container(),),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF64C251),
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text,
                          password: _passwordTextController.text).then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Mynavigationbar()));
                      }).onError((error, stackTrace){
                        print("Error ${error.toString()}");
                      });

                    },
                    child: const Text('LOGIN'),
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
                SizedBox(height: 50,),
                RichText(text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.black38,
                    fontFamily: 'Inter',
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                    text: " Create account",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF64C251),
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                      recognizer: TapGestureRecognizer()..onTap=() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
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

