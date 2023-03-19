import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:poodle_mobie_application/nav_pages/e_vaccine.dart';
import 'package:poodle_mobie_application/nav_pages/scan_page.dart';
import 'package:poodle_mobie_application/nav_pages/search_page.dart';

import '../nav_pages/front_page.dart';

class Mynavigationbar extends StatefulWidget {
  const Mynavigationbar({Key? key}) : super(key: key);

  @override
  State<Mynavigationbar> createState() => _MynavigationbarState();
}

class _MynavigationbarState extends State<Mynavigationbar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _pages = [
    FrontPage(),
    Search(),
    VaccineCard(),
    Scane(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF072972),
        selectedItemColor: Color(0xFF64C251),
        unselectedItemColor: Colors.white.withOpacity(.70),
        selectedFontSize: 14,
        unselectedFontSize: 14,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home) ,label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.vaccines), label:'E-card'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_overscan), label:'Scan dog'),
        ],

        // color: Color(0xFF072972),
        // child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5 ),
        //       child: GNav(
        //         gap: 9,
        //         backgroundColor: Color(0xFF072972),
        //         color: Colors.white,
        //         activeColor: Colors.white,
        //         tabBackgroundColor: Color(0xFF64C251),
        //         padding: EdgeInsets.all(16),
        //         tabs: [
        //           GButton(icon: Icons.home, text:'Home'),
        //           GButton(icon: Icons.search_rounded, text: 'Search'),
        //           GButton(icon: Icons.vaccines, text:'E-card'),
        //           GButton(icon: Icons.settings_overscan, text:'Scan dog'),
        //         ],
        //       ),
        //     ),
          ),
    );
  }
}
