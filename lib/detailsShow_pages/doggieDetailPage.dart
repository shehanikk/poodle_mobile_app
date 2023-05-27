import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DoggieDetailsPage extends StatefulWidget {

 final String dogName;

  const DoggieDetailsPage({
    Key? key,
    required this.dogName
  }) : super(key: key);



  @override
  State<DoggieDetailsPage> createState() => _DoggieDetailsPageState();
}

class _DoggieDetailsPageState extends State<DoggieDetailsPage> {
  List _vaccineDetails = [];
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
    fetchVaccineDetails();
  }

  fetchVaccineDetails() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection('userDog').doc(email).collection('dog').doc(widget.dogName).collection('Vaccine').get();
    setState(() {
      for (int i=0; i<qn.docs.length; i++){
        _vaccineDetails.add(
            {
              "Date" : qn.docs[i]["Date"],
              "DocName" : qn.docs[i]["DocName"],
              "DueDate" : qn.docs[i]["DueDate"],
              "imgUrl" : qn.docs[i]["imgUrl"],
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
        title: Text('Vaccine Card'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                //margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 800.0,
                width: 300,
                child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _vaccineDetails.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 0.9),
                    itemBuilder: (_,index){
                        return Card(
                          elevation: 5,
                          color: Color(0xFFEEEEEE),
                          margin: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              AspectRatio(aspectRatio: 1.4, child: Container( child: Image.network(_vaccineDetails[index]["imgUrl"]))),
                              SizedBox(height: 7,),
                              Text( "Date: ${_vaccineDetails[index]["Date"]}"),
                              SizedBox(height: 7,),
                              Text("Doctor name: ${_vaccineDetails[index]["DocName"]}"),
                              SizedBox(height: 7,),
                              Text("Next vaccine: ${_vaccineDetails[index]["DueDate"]}"),
                            ],
                          ),
                      );
                    }),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
