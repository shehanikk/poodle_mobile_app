import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poodle_mobie_application/login_pages/choose_page.dart';
import 'package:poodle_mobie_application/main_pages/navigationbar.dart';
import 'package:poodle_mobie_application/services/theme_services.dart';
import 'package:poodle_mobie_application/ui_design/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),


      // home: const Choose(),
      home: const  Mynavigationbar(),
    );
  }
}
