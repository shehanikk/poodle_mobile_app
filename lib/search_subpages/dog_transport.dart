import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poodle_mobie_application/detailsShow_pages/dogFoodDetailPage.dart';

class Dogtrans extends StatefulWidget {
  const Dogtrans({Key? key}) : super(key: key);

  @override
  State<Dogtrans> createState() => _DogtransState();
}

class _DogtransState extends State<Dogtrans> {
  List _addvertisments = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchAddvertisments() async {

    QuerySnapshot qn =
    await _firestoreInstance.collection("addvertisments").where('addCategories', isEqualTo: 'Dog transportation').get();
    setState(() {
      for (int i=0; i<qn.docs.length; i++){
        _addvertisments.add(
            {
              "addCategories" : qn.docs[i]["addCategories"],
              "addDescription" : qn.docs[i]["addDescription"],
              "addLocation" : qn.docs[i]["addLocation"],
              "addName" : qn.docs[i]["addName"],
              "addNumber" : qn.docs[i]["addNumber"],
              "addPrice" : qn.docs[i]["addPrice"],
              "author" : qn.docs[i]["author"],
              "imgUrl" : qn.docs[i]["imgUrl"],
            }
        );
      }
    });
  }

  @override
  void initState() {
    fetchAddvertisments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('TRANSPORT'),
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
                    itemCount: _addvertisments.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 0.9),
                    itemBuilder: (_,index){
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DogFoodDetailPage(addvertisments: _addvertisments[index],
                            ),
                            ),
                            );
                          },
                      child: Card(
                        elevation: 5,
                        color: Color(0xFFEEEEEE),
                        margin: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            AspectRatio(aspectRatio: 1.4, child: Container( child: Image.network(_addvertisments[index]["imgUrl"]))),
                            SizedBox(height: 7,),
                            Text( "Name: ${_addvertisments[index]["addName"]}"),
                            SizedBox(height: 7,),
                            Text("Location: ${_addvertisments[index]["addLocation"]}"),
                            SizedBox(height: 7,),
                            Text("Price: ${_addvertisments[index]["addPrice"]}"),
                          ],
                        ),
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
