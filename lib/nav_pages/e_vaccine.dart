import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/sub_pages/dog_account_create.dart';
import 'package:poodle_mobie_application/sub_pages/exist_vaccine.dart';

class VaccineCard extends StatefulWidget {
  const VaccineCard({Key? key}) : super(key: key);

  @override
  State<VaccineCard> createState() => _VaccineCardState();
}

class _VaccineCardState extends State<VaccineCard> {



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('VET CARE'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {},
        //     color: Colors.white,
        //   ),
        // ],
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              width: w*0.8,
              height: h*0.13,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/vet_careTop.png"
                      ),
                      fit: BoxFit.cover
                  )
              ),
            ),


            SizedBox(
              height: 25,
            ),


            Container(
              child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DogCreate()));

                },
                child: const Text('Create account'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(const Size(190, 53)),
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

            SizedBox(
              height: 20,
            ),

            Container(
              child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExistAccount()));

                },
                child: const Text('Exist account'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(const Size(190, 53)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF64C251)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 17,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 34,
            ),

            Container(
              width: w*100,
              height: h*0.484,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/vaccine_bottom.png"
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
