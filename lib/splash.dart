import 'package:flutter/material.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState ();
    _navigatetohome ();
}

_navigatetohome() async{
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage (title:'GFG')));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                'assets/splash_screen.png',
                width: 746.3,
                height: 912.4,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
    );
  }
}
