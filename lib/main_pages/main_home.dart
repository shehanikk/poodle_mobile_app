import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_page.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
            color: Colors.black,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.black,
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.white,
      ),

      bottomNavigationBar: Container(
        color: Color(0xFF072972),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5 ),
          child: GNav(
            gap: 9,
            backgroundColor: Color(0xFF072972),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xFF64C251),
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.home, text:'Home'),
              GButton(icon: Icons.search_rounded, text: 'Search'),
              GButton(icon: Icons.vaccines, text:'E-card'),
              GButton(icon: Icons.settings_overscan, text:'Scan dog'),

            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w*100,
              height: h*0.21,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/home_top_img.png"
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ],
        ),
      ),

    );
  }
}
