import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/detailsShow_pages/doggieDetailPage.dart';
import 'package:poodle_mobie_application/detailsShow_pages/donationDetailsPage.dart';
import '../main_pages/home_page.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  List _donations = [];
  var _firestoreInstance = FirebaseFirestore.instance;



  fetchDonations() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("donations").get();
    setState(() {
      for (int i=0; i<qn.docs.length; i++){
        _donations.add(
          {
            "dogDescription" : qn.docs[i]["dogDescription"],
            "dogName" : qn.docs[i]["dogName"],
            "healthState" : qn.docs[i]["healthState"],
            "imgUrl" : qn.docs[i]["imgUrl"],
          }
        );
      }
    });
  }

  @override
  void initState() {
    fetchDonations();
    super.initState();
  }

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
            SizedBox(height: 25,),
            Container(
              width: w*100,
              height: h*0.30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/don_im.png"
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: 25,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: 190.0,
                  child: GridView.builder(
                      shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemCount: _donations.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1.1),
                      itemBuilder: (_,index){
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DonationDetailsPage(donation: _donations[index]),
                            ),
                            );
                          },
                        child: Card(
                          elevation: 5,
                          color: Color(0xFFEEEEEE),
                          child: Column(
                            children: [
                             AspectRatio(aspectRatio: 1.4, child: Container( child: Image.network(_donations[index]["imgUrl"]))),
                              SizedBox(height: 7,),
                              Text( "Name: ${_donations[index]["dogName"]}"),
                              SizedBox(height: 7,),
                              Text("${_donations[index]["healthState"]}"),
                            ],
                          ),
                        ),
                        );
                  }),
              ),
          ],
        ),
      ),
    );
  }
}
