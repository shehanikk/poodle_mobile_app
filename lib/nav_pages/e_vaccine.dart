import 'package:flutter/material.dart';
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

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('VET CARE'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),

      body: Column(
        children: [
        Container(
          child: ElevatedButton(

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExistAccount()));

            },
            child: const Text('Exist account'),
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
        ]
      ),
    );
  }
}
