import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/detailsShow_pages/doggieDetailPage.dart';
import 'package:poodle_mobie_application/sub_pages/reminder_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExistAccount extends StatefulWidget {
  const ExistAccount({Key? key}) : super(key: key);

  @override
  State<ExistAccount> createState() => _ExistAccountState();
}

class _ExistAccountState extends State<ExistAccount> {
  List _dogsDeatils = [];
  var _firestoreInstance = FirebaseFirestore.instance;

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
    fetchDogDetails();
  }

  fetchDogDetails() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection('userDog').doc(email).collection('dog').get();
    setState(() {
      for (int i=0; i<qn.docs.length; i++){
        _dogsDeatils.add(
            {
              "dogBirthDay" : qn.docs[i]["dogBirthDay"],
              "dogBreed" : qn.docs[i]["dogBreed"],
              "dogName" : qn.docs[i]["dogName"],
              "dogSex" : qn.docs[i]["dogSex"],
              "imageUrl" : qn.docs[i]["imageUrl"],
            }
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('Pet profile'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                //margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 700.0,
                width: 300,
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _dogsDeatils.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 0.9),
                    itemBuilder: (_,index){

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DoggieDetailsPage(dogName: _dogsDeatils[index]["dogName"]),
                            ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            color: Color(0xFFEEEEEE),
                            margin: EdgeInsets.all(25),
                            child: Column(
                              children: [
                                AspectRatio(aspectRatio: 1.4, child: Container( child: Image.network(_dogsDeatils[index]["imageUrl"]))),
                                SizedBox(height: 7,),
                                Text("Name: ${_dogsDeatils[index]["dogName"]}"),
                                SizedBox(height: 7,),
                                Text("Breed: ${_dogsDeatils[index]["dogBreed"]}"),
                                SizedBox(height: 7,),
                                Text("Birthday: ${_dogsDeatils[index]["dogBirthDay"]}"),
                                SizedBox(height: 7,),
                                Text("Gender: ${_dogsDeatils[index]["dogSex"]}"),
                              ],
                            ),
                      ),
                        );
                    }),
              ),
            ),
            Container(
              child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Reminder()));
                },
                child: const Text('Reminder'),
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

            )
          ],
        ),
      ),

      // body: Column(
      //     children: [
      //       Container(
      //         child: ElevatedButton(
      //
      //           onPressed: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => Reminder()));
      //           },
      //           child: const Text('Reminder'),
      //           style: ButtonStyle(
      //             shape: MaterialStateProperty.all(
      //               RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(20),
      //               ),
      //             ),
      //             fixedSize: MaterialStateProperty.all(const Size(345.9, 60.1)),
      //             backgroundColor: MaterialStateProperty.all(Color(0xFF64C251)),
      //             foregroundColor: MaterialStateProperty.all(Colors.black),
      //             textStyle: MaterialStateProperty.all(
      //               const TextStyle(
      //                 fontFamily: 'Inter',
      //                 color: Colors.black,
      //                 fontSize: 17,
      //                 letterSpacing: 1,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ]
      // ),


    );
  }
}
