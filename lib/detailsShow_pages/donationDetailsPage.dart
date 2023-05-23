import 'package:flutter/material.dart';


class DonationDetailsPage extends StatefulWidget {
  final Map<String, dynamic> donation;

  const DonationDetailsPage({Key? key, required this.donation}) : super(key: key);


  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF072972),
        centerTitle: true,
        title: Text('DONATION DETAILS'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: Container(
              child: Image.network(widget.donation['imgUrl']),
            ),
          ),
          SizedBox(height: 28),
          Text("Dog Name: ${widget.donation['dogName']}", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 25),
          Text("Health State: ${widget.donation['healthState']}", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 35),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("${widget.donation['dogDescription']}", textAlign: TextAlign.justify, style: TextStyle(
              fontSize: 20,

            ),),
          ),

        ],
      ),
    );
  }
}
