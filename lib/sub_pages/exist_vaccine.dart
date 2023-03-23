import 'package:flutter/material.dart';
import 'package:poodle_mobie_application/sub_pages/reminder_page.dart';


class ExistAccount extends StatefulWidget {
  const ExistAccount({Key? key}) : super(key: key);

  @override
  State<ExistAccount> createState() => _ExistAccountState();
}

class _ExistAccountState extends State<ExistAccount> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('Pet profile'),
      ),

      body: Column(
          children: [
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
            ),
          ]
      ),

    );
  }
}
